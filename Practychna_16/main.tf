terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key  = var.MONGODB_ATLAS_PUBLIC_KEY
  private_key = var.MONGODB_ATLAS_PRIVATE_KEY
}

resource "mongodbatlas_project" "myproject" {
  name   = "My Project"
  org_id = var.MONGODB_ATLAS_ORGANIZATION_ID
}

resource "mongodbatlas_cluster" "mycluster" {
  project_id   = mongodbatlas_project.myproject.id
  name         = "mycluster"
  cluster_type = "REPLICASET"
  provider_name = "TENANT"
  backing_provider_name = "AWS"
  provider_region_name = "US_EAST_1"
  provider_instance_size_name = "M0"
}

resource "mongodbatlas_database_user" "bob" {
  username = "bob"
  password = "fXUJAFkf5ZZbuY6z"
  auth_database_name = "admin"
  project_id = mongodbatlas_project.myproject.id
  depends_on = [mongodbatlas_cluster.mycluster]
  roles {
    role_name     = "readWrite"
    database_name = "mydb" 
  }
}

locals {
  cidr_block_list = [
    { cidr_block = "0.0.0.0/1", comment = "CIDR Block 1" },
    { cidr_block = "128.0.0.0/1", comment = "CIDR Block 2" },
  ]
}

resource "mongodbatlas_project_ip_access_list" "cidr" {
  for_each = { for index, cidr in local.cidr_block_list : cidr.comment => cidr }
  project_id = mongodbatlas_project.myproject.id
  cidr_block = each.value.cidr_block
  comment    = each.value.comment
  depends_on = [mongodbatlas_cluster.mycluster]
}
