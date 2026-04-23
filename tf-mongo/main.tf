terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.MONGODB_ATLAS_PUBLIC_KEY
  private_key = var.MONGODB_ATLAS_PRIVATE_KEY
}

# Project
resource "mongodbatlas_project" "project" {
  name   = "tf-project"
  org_id = var.MONGODB_ATLAS_ORGANIZATION_ID
}

# Cluster (M0 free tier)
resource "mongodbatlas_cluster" "cluster" {
  project_id = mongodbatlas_project.project.id
  name       = "tf-cluster"

  provider_name               = "TENANT"
  backing_provider_name      = "AWS"
  provider_instance_size_name = "M0"
  provider_region_name        = "EU_CENTRAL_1"
}

# Database user
resource "mongodbatlas_database_user" "user" {
  username           = "bob"
  password           = "fXUJAFkf5ZZbuY6z"
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "test"
  }
}

# Allow access from anywhere (для тесту)
resource "mongodbatlas_project_ip_access_list" "access" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
}
