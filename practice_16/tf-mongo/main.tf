terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
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
  username           = "bob"
  password           = "fXUJAFkf5ZZbuY6z"
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.myproject.id

  roles {
    role_name     = "readWrite"
    database_name = "mydb"
  }

  depends_on = [mongodbatlas_cluster.mycluster]
}

resource "mongodbatlas_project_ip_access_list" "all" {
  project_id = mongodbatlas_project.myproject.id
  cidr_block = "0.0.0.0/0"

  depends_on = [mongodbatlas_cluster.mycluster]
}
