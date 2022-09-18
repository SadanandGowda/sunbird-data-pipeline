#provider "helm" {
#  kubernetes {
#    config_path = var.KUBE_CONFIG_PATH
#    config_context = "one-click"  
#}
#}

#provider "kubernetes" {
#  config_path = var.KUBE_CONFIG_PATH
#  config_context = "one-click"
#}

resource "helm_release" "druid_cluster" {
  name             = "druid-cluster"
#  chart            = "../druid-cluster"
  chart            = var.DRUID_CLUSTER_CHART
#  repository       = "/Users/sada/z/azure/infra-terraform-databus-observations/helm_charts"
  namespace        = var.DRUID_NAMESPACE
  create_namespace = true
#  depends_on       = [postgresql_role.application_role, helm_release.obs_druid_operator]
  depends_on       = [helm_release.druid_operator,]
  wait_for_jobs    = true
#  azure_storage_account = var.StorageAcc
 timeout           = 3000  
  values = [
    templatefile("/Users/sada/z/local/druid-cluster/values.yaml",
      {
        end_point = "postgres-postgresql.postgres",
        druid_namespace = var.DRUID_NAMESPACE
        druid_user  = "druid"
        druid_password  = "druid"
        druid_worker_capacity = var.DRUID_MIDDLE_MANAGER_WORKER_NODES
        deployment_stage = var.STAGE
      }
    )
  ]
}



data "kubernetes_service" "druid" {
  metadata {
    namespace = "druid-raw"
    name = "druid-cluster-zookeeper"
  }
depends_on       = [helm_release.druid_cluster, helm_release.druid_operator]
}
resource "helm_release" "druid_operator" {
  name             = "druid-operator"
#  chart            = "../druid-operator"
  chart            =  var.DRUID_OPERATOR_CHART
#  repository       = "/Users/sada/z/azure/infra-terraform-databus-observations/helm_charts"
  create_namespace = true
  namespace        = var.DRUID_NAMESPACE
  wait_for_jobs    = true
  depends_on = [
   kind_cluster.one-click, helm_release.postgres
  ]
}
