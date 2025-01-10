# Create a VM for the load generator
resource "google_compute_instance" "load_generator" {
  name         = "load-generator"
  machine_type = "e2-standard-2"
  zone         = var.region

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "default"

    access_config {
    }
  }


  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
    cd microservices-demo/src/loadgenerator/
    sudo docker build -t locust-loadgen .
    #sudo docker run -d -p 8089:8089 -e FRONTEND_ADDR="34.91.127.201" -e USERS=50 locust-loadgen
    sudo docker run -d -p 8089:8089 --entrypoint locust locust-loadgen --host="http://34.34.93.212" --headless --users=100  --spawn-rate=1
    EOT
}




