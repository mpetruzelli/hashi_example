job "simple_container" {
  datacenters = ["dc1"]
  type        = "batch"

  group "simple_container" {
    count = 1

    task "simple_container" {
      driver = "docker"

      config {
        image   = "${NOMAD_META_image}:${NOMAD_META_tag}"
        command = "/bin/echo"
        args    = ["'Hello ContainerLand'"]
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
