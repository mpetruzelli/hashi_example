job "every_minute" {
  datacenters = ["dc1"]
  type        = "batch"

  periodic {
    cron             = "* */1 * * * *"
    prohibit_overlap = true
  }

  group "every_minute" {
    count = 1

    task "every_minute" {
      driver = "docker"

      config {
        image   = "${NOMAD_META_image}:${NOMAD_META_tag}"
        command = "/bin/bash"
        args    = ["-c", "echo 'Running every minute!' > /tmp/output.txt"]
        volumes = ["tmp:/tmp"]
      }

      meta {
        image = "ubuntu"
        tag         = "18.04"
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}
