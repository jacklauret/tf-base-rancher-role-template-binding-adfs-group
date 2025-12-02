
# tf-base-rancher-role-template-binding-adfs-group

This Terraform module creates Rancher project role bindings for ADFS groups.

## Overview
The module binds ADFS groups as "Owner", "Member" or "Readonly" to a Rancher project in a cluster. The groups receive the corresponding roles in the project.

## Resources
- `rancher2_project_role_template_binding` for owner, member and readonly groups
- Data sources for cluster and project

## Input Variables
| Name                | Type    | Description                                      | Required    | Default |
|---------------------|---------|--------------------------------------------------|-------------|---------|
| cluster_api_url     | string  | Rancher API URL                                  | Yes         | -       |
| rancher_access_key  | string  | Rancher access key (sensitive)                   | Yes         | -       |
| rancher_secret_key  | string  | Rancher secret key (sensitive)                   | Yes         | -       |
| target_cluster_name | string  | Name of the target cluster                       | Yes         | -       |
| project_name        | string  | Name of the project                              | Yes         | -       |
| owner_group_id      | string  | ADFS group ID for owner                          | No          | ""      |
| owner_group_name    | string  | ADFS group name for owner                        | No          | ""      |
| member_group_id     | string  | ADFS group ID for member                         | No          | ""      |
| member_group_name   | string  | ADFS group name for member                       | No          | ""      |
| readonly_group_id   | string  | ADFS group ID for readonly                       | No          | ""      |
| readonly_group_name | string  | ADFS group name for readonly                     | No          | ""      |

## Example
```hcl
module "rancher_role_binding" {
  source              = "./tf-base-rancher-role-template-binding-adfs-group"
  cluster_api_url     = "https://rancherlab.de.eu.sew"
  rancher_access_key  = "<ACCESS_KEY>"
  rancher_secret_key  = "<SECRET_KEY>"
  target_cluster_name = "t-bru-01"
  project_name        = "harbor"
  owner_group_id      = "adfs_group://de\\l-k8s-test"
  owner_group_name    = "l-k8s-test"
  member_group_id     = "adfs_group://de\\l-k8s-test-2"
  member_group_name   = "l-k8s-test-2-1"
}
```

## Provider
```hcl
terraform {
  required_version = ">=1.10.6"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">=8.3.1"
    }
  }
}

provider "rancher2" {
  api_url    = var.cluster_api_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
}
```

## Notes
- The group variables can be left empty if no binding is needed for the respective role.
- The names of the groups are used for the binding and should be unique.

## Author
This module was created by jacklauret.
