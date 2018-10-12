job "demo-app" {
  datacenters = ["dc1"]
  type        = "batch"

  periodic {
    cron = "@weekly"
  }

  parameterized {
    payload       = "optional"
    meta_required = ["ACCOUNT"]
    meta_optional = ["VERSION", "FORCE"]
  }

  meta {
    VERSION = "3.0"
    FORCE   = "false"
    ACCOUNT = "DEV"
  }

  group "demo-app" {
    count = 1

    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 10
      interval = "5m"

      # The "delay" parameter specifies the duration to wait before restarting
      # a task after it has failed.
      delay = "25s"

      mode = "delay"
    }

    task "demo-app" {
      driver = "docker"

      config {
        image = "ubuntu/dre/blue:2.0.0"
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
      }
    }
  }
}
