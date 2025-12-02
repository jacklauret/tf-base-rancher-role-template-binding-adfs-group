# tf-base-rancher-role-template-binding-adfs-group

Dieses Terraform-Modul erstellt Rancher Projekt-Rollenbindungen für ADFS-Gruppen.

## Übersicht
Das Modul bindet ADFS-Gruppen als "Owner", "Member" oder "Readonly" an ein Rancher-Projekt in einem Cluster. Die Gruppen erhalten entsprechende Rollen im Projekt.

## Ressourcen
- `rancher2_project_role_template_binding` für Owner, Member und Readonly Gruppen
- Datenquellen für Cluster und Projekt

## Eingabevariablen
| Name                | Typ     | Beschreibung                                      | Erforderlich | Default |
|---------------------|---------|---------------------------------------------------|-------------|---------|
| cluster_api_url     | string  | Die Rancher API URL                               | Ja          | -       |
| rancher_access_key  | string  | Rancher Access Key (sensitiv)                     | Ja          | -       |
| rancher_secret_key  | string  | Rancher Secret Key (sensitiv)                     | Ja          | -       |
| target_cluster_name | string  | Name des Ziel-Clusters                            | Ja          | -       |
| project_name        | string  | Name des Projekts                                 | Ja          | -       |
| owner_group_id      | string  | ADFS-Gruppen-ID für Owner                         | Nein        | ""      |
| owner_group_name    | string  | ADFS-Gruppen-Name für Owner                       | Nein        | ""      |
| member_group_id     | string  | ADFS-Gruppen-ID für Member                        | Nein        | ""      |
| member_group_name   | string  | ADFS-Gruppen-Name für Member                      | Nein        | ""      |
| readonly_group_id   | string  | ADFS-Gruppen-ID für Readonly                      | Nein        | ""      |
| readonly_group_name | string  | ADFS-Gruppen-Name für Readonly                    | Nein        | ""      |

## Beispiel
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

## Hinweise
- Die Gruppenvariablen können leer bleiben, wenn keine Bindung für die jeweilige Rolle benötigt wird.
- Die Namen der Gruppen werden für die Bindung verwendet und sollten eindeutig sein.

## Autor
Dieses Modul wurde von jacklauret erstellt.
