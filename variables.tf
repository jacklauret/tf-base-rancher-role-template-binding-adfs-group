variable "cluster_api_url" {
  type = string
  description = "the rancher api url"
  validation {
    condition = can(regex("^https?://([\\w.-]+)(:[0-9]{2,5})?(/.*)?$", var.cluster_api_url))
    error_message = "Value must be a valid HTTP/HTTPS URL (e.g., https://example.com, https://example.com:8443/api)."
  }
}

variable "rancher_access_key" {
  type = string
  sensitive = true
  description = "Rancher access key for accessing rancher"
}

variable "rancher_secret_key" {
  type = string
  sensitive = true
  description = "Rancher secret key for accessing rancher"
}

variable "target_cluster_name" {
  type = string
  nullable = false
  description = "Name of the target cluster"
}

variable "project_name" {
  type = string
  nullable = false
  description = "Name of the project"
}

variable "owner_group_id" {
  type = string
  nullable = true
  default = ""
}

variable "owner_group_name" {
  type = string
  nullable = true
  default = ""
}

  variable "member_group_id" {
  type = string
  nullable = true
  default = ""
  }

  variable "member_group_name" {
    type = string
    nullable = true
    default = ""  
  }

    variable "readonly_group_id" {
  type = string
  nullable = true
  default = ""
  }

  variable "readonly_group_name" {
    type = string
    nullable = true
    default = ""  
  }