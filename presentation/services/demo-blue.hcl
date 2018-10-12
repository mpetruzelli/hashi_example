job "demo-app" {
  datacenters = ["dc1"]
  type        = "service"

  group "demo-app" {
    count = 3

    task "demo-app" {
      driver = "docker"

      env {
        version = "2.0.0"
      }

      config {
        image = "ubuntu/dre/blue:${version}"

        port_map {
          http = 8081
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB

        network {
          mbits = 10

          port "http" {}
        }
      }

      service {
        name = "demo-app-blue"
        tags = ["urlprefix-/${NOMAD_TASK_NAME} strip=/${NOMAD_TASK_NAME}", "${NOMAD_TASK_NAME}", "blue"]
        port = "http"

        check {
          name     = "demo-app-blue"
          type     = "http"
          path     = "/version"
          port     = "http"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
