job "simple_run" {
  datacenters = ["dc1"]
  type        = "batch"

  group "simple_run" {
    count = 1

    task "simple_run" {
      driver = "raw_exec"

      config {
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
