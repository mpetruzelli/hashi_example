job "fabio" {
  datacenters = ["dc1"]
  type        = "system"

  group "fabio" {
    count = 1

    task "fabio" {
      driver = "raw_exec"

      env {
        log_level = "DEBUG"
      }

      config {
        command = "/usr/local/bin/fabio"
      }

      resources {
        cpu    = 1000
        memory = 1000
      }
    }
  }
}
