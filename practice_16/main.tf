terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.0"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.MONGODB_ATLAS_PUBLIC_KEY
  private_key = var.MONGODB_ATLAS_PRIVATE_KEY
}

resource "mongodbatlas_project" "lab_project" {
  name   = "Terraform-Project-Alina"
  org_id = var.MONGODB_ATLAS_ORGANIZATION_ID
}

resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.lab_project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Allow access for Lab"
}