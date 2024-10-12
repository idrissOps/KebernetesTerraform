//Fichier de deployement de l'application
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
        name= "frontend"
    }
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        test = "webapp"
      }
    }

    template {
      metadata {
        labels = {
        name="webapp"
         
        }
      }

      spec {
        container {
          image = "kodekloud/webapp-color:v1"
          name  = "simple-web-app"
          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}



//Service

resource "kubernetes_service" "webApp-service" {
  metadata {
    name = "webapp-service"
  }
  spec {
    selector = {
        name="webapp"
      //app = kubernetes_pod.example.metadata.0.labels.app
    }
    
    port {
      port        = 8080
      target_port = 8080
      node_port = 30080
    }

    type = "NodePort"
  }
}
