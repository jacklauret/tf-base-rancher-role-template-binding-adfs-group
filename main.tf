data "rancher2_cluster_v2" "cluster" {
  name = var.target_cluster_name
  fleet_namespace = "fleet-default"
}

data "rancher2_project" "project" {
  name       = var.project_name
  cluster_id = data.rancher2_cluster_v2.cluster.cluster_v1_id
}

resource "rancher2_project_role_template_binding" "role_template_binding_group_owner" {
  count             = (var.owner_group_id != "" && var.owner_group_name != "") ? 1 : 0
  user_principal_id = var.owner_group_id   
  project_id        = data.rancher2_project.project.id
  role_template_id  = "project-owner"
  name              = var.owner_group_name
}

resource "rancher2_project_role_template_binding" "role_template_binding_group_member" {
  count             = (var.member_group_id != "" && var.member_group_name != "") ? 1 : 0
  group_principal_id = var.member_group_id
  project_id        = data.rancher2_project.project.id
  role_template_id  = "project-member"
  name              = lower(var.member_group_name)
}

resource "rancher2_project_role_template_binding" "role_template_binding_group_readonly" {
  count             = (var.readonly_group_id != "" && var.readonly_group_name != "") ? 1 : 0
  group_principal_id = var.readonly_group_id
  project_id        = data.rancher2_project.project.id
  role_template_id  = "project-member"
  name              = lower(var.readonly_group_name)
}
