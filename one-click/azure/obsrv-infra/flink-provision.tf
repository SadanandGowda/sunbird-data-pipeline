resource "helm_release" "flink" {
  name             = "flink-dev"
#  chart            = "../druid-cluster"
  chart            = var.FLINK_CHART
#  repository       = "/Users/sada/z/azure/infra-terraform-databus-observations/helm_charts"
  namespace        = var.FLINK_NAMESPACE
  create_namespace = true
#  depends_on       = [postgresql_role.application_role, helm_release.obs_druid_operator]
  depends_on       = [helm_release.kafka]
  wait_for_jobs    = true
  
  values = [
    templatefile("/Users/sada/z/azure/pipeline_jobs/values.yaml",
      {
        kafka-broker = data.kubernetes_service.kafka.status.0.load_balancer.0.ingress.0.ip
        input_topic = "dev.telemetry.ingest"
        output_topic = "dev.telemetry.raw"
        deployment_stage = var.STAGE
      }
    )
  ]
}
data "kubernetes_service" "flink" {
  metadata {
    namespace = "flink"
    name = "flink-service"
  }
depends_on       = [azurerm_kubernetes_cluster.aks]
}


