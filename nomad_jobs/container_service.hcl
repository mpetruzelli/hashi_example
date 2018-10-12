job "container-echo" {
  datacenters = ["dc1"]
  type        = "batch"

  group "container-echo" {
    count = 1

    restart {
      attempts = 2
      interval = "5m"
      delay    = "25s"
      mode     = "fail"
    }

    task "container-echo" {
      driver = "docker"

      config {
        image = "ubuntu:latest"
        command = "/bin/echo"
        args    = ["Hello World!"]
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}
