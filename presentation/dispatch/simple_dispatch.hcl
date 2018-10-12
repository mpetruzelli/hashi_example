job "simple_dispatch" {
  datacenters = ["dc1"]
  type        = "batch"

  parameterized {
    meta_required = ["string"]
  }

  group "simple_dispatch" {
    count = 1

    task "simple_dispatch" {
      driver = "docker"

      config {
        image   = "${NOMAD_META_image}:${NOMAD_META_tag}"
        command = "/bin/bash"
        args    = ["-c", "echo '${NOMAD_META_string}' > /tmp/output.txt"]
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
