terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.16"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.MONGODB_ATLAS_PUBLIC_KEY
  private_key = var.MONGODB_ATLAS_PRIVATE_KEY
}

# Project
resource "mongodbatlas_project" "project" {
  name   = "my-terraform-project"
  org_id = var.MONGODB_ATLAS_ORGANIZATION_ID
}

# Cluster (M0 - Free tier)
resource "mongodbatlas_cluster" "cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = "my-cluster"
  cluster_type = "REPLICASET"

  provider_name               = "TENANT"
  backing_provider_name      = "AWS"
  provider_region_name       = "EU_CENTRAL_1"

  provider_instance_size_name = "M0"
}

# Database User
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

# IP Access List (дозволити всі IP — для тесту)
resource "mongodbatlas_project_ip_access_list" "access_list" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Allow all (test only)"
}
