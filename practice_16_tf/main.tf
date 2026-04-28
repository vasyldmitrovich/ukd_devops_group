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

resource "mongodbatlas_project" "project" {
  name   = "Project_Nazar_Level4"
  org_id = var.MONGODB_ATLAS_ORGANIZATION_ID
}

resource "mongodbatlas_cluster" "cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = "ClusterNazar"
  
   provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_instance_size_name = "M0"
  provider_region_name        = "EU_CENTRAL_1" 
}

resource "mongodbatlas_database_user" "user" {
  username           = "bob"
  password           = "fXUJAFkf5ZZbuY6z"
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
}

resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Allow access from anywhere"
}
