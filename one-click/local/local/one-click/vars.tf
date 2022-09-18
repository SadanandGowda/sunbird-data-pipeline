variable "kind_cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = "one-click"
}

variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "/Users/sada/z/local/one-click/kube_local.yaml"
}

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The Helm version for the nginx ingress controller."
  default     = "4.0.6"
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The nginx ingress namespace (it will be created if needed)."
  default     = "ingress-nginx"
}


variable "STAGE" {
  description = "Deployment Stage"
  default     = "dev"
}

#DRUID
variable "DRUID_CLUSTER_CHART" {
  description = "Druid Instance Running Namespace"
  default     = "../druid-cluster"
}

variable "DRUID_NAMESPACE" {
  description = "Druid Instance Running Namespace"
  default     = "druid-raw"
}

variable "DRUID_OPERATOR_CHART" {
  description = "Druid Instance Running Namespace"
  default     = "../druid-operator"
}

variable "DRUID_MIDDLE_MANAGER_WORKER_NODES" {
  type    = number
  default = 3
}
variable "DRUID_MIDDLE_MANAGER_PEON_HEAP" {
  type    = string
  default = "256M"
}

#KAFKA
variable "KAFKA_CHART" {
  description = "Kafka Instance Running Namespace"
  default     = "../kafka"
}

variable "KAFKA_NAMESPACE" {
  description = "KAFKA Instance Running Namespace"
  default     = "kafka"
}

#SUPERSET

variable "SUPERSET_NAMESPACE" {
  type    = string
  default = "superset"
}

variable "SUPERSET_ADMIN_USERNAME" {
  type    = string
  default = "admin"
}
variable "SUPERSET_ADMIN_FIRSTNAME" {
  type    = string
  default = "Superset"
}

variable "SUPERSET_ADMIN_LASTNAME" {
  type    = string
  default = "Admin"
}

variable "SUPERSET_ADMIN_PASSWORD" {
  type    = string
default   = "admin123"
}
variable "SUPERSET_ADMIN_EMAIL" {
  type    = string
  default = "admin@superset.com"
}

