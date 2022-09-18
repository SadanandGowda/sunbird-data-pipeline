#resource "kubernetes_storage_class" "local" {
#  metadata {
#    name = "local"
#  }
#  storage_provisioner = "local"
#  reclaim_policy      = "Delete"
#  parameters = {
#    type = "pd-standard"
#  }
#  mount_options = ["file_mode=0700", "dir_mode=0777", "mfsymlinks", "uid=1000", "gid=1000", "nobrl", "cache=none"]
#}


provider "helm" {
  kubernetes {
      config_path = "/Users/sada/z/local/one-click/kube_local.yaml"
      config_context = "kind-one-click"
}
}


resource "helm_release" "postgres"{
name = "postgres"

chart = "../postgresql"

#repository = "bitnami"
namespace        = "postgres"
create_namespace = true

depends_on       = [kind_cluster.one-click]

wait_for_jobs    = true

values = [
templatefile("/Users/sada/z/local/postgresql/values.yaml",
{
 #      druid_user  = "druid",
#        druid_password  = "druid"
}
)
]
}


