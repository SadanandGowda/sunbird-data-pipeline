resource "kubernetes_persistent_volume" "postgres-pv" {
#depends_on  = [kind_cluster.one-click]
  metadata {
    name = "postgres-pv"
  }
  spec {
    capacity = {
      storage = "1Gi"
     }
    storage_class_name = "standard"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "worker-node"
            operator = "In"
            values = ["true"]
           }
           }
           }     
           }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      local {
        path = "/mnt/data"
      }
    }
  }
   depends_on = [kind_cluster.one-click]
}

resource "kubernetes_persistent_volume_claim" "postgres-pvc" {
  metadata {
    name = "postgres-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.postgres-pv.metadata.0.name}"
  }
depends_on = [kind_cluster.one-click]
}