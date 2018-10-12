job "demo-app" {
  datacenters = ["dc1"]
  type        = "service"

  update {
    max_parallel      = 1
    min_healthy_time  = "10s"
    health_check      = "checks"
    healthy_deadline  = "3m"
    progress_deadline = "6m"
    auto_revert       = true
    stagger           = "30s"
    canary            = 1
  }

  migrate {
    max_parallel     = 1
    min_healthy_time = "10s"
    healthy_deadline = "6m"
  }

  group "demo-app" {
    count = 3

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    ephemeral_disk {
      size = 300
    }

    task "demo-app" {
      driver = "docker"

      config {
        image = "ubuntu/dre/${color}:${version}"

        port_map {
          http = 8081
        }
      }

      template {
        data = <<EOH
version="{{ key "service/config/version" }}"
color="{{ key "service/config/color" }}"
EOH

        destination = "local/config.env"
        env         = true
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
        name = "demo-app-green"

        tags = ["urlprefix-/${NOMAD_TASK_NAME} strip=/${NOMAD_TASK_NAME}", "${NOMAD_TASK_NAME}", "${color}"]
        port = "http"

        check {
          name     = "demo-app-green"
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
