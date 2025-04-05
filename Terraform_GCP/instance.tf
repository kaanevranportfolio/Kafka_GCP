resource "google_compute_instance" "kafka_instance" {
  name         = "kafka-instance"
  machine_type = var.instance_type
  zone         = var.zone
  tags         = ["ssh-access", "kafka-access"]

  boot_disk {
    initialize_params {
      image = var.instance_image["ubuntu"]
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  metadata = {
    ssh-keys = "kaanevran:${file("../keys/kfk-key.pub")}"
  }
}



resource "google_compute_instance" "control_instance" {
  name         = "control-instance"
  machine_type = var.instance_type
  zone         = var.zone
  tags         = ["ssh-access"]

  boot_disk {
    initialize_params {
      image = var.instance_image["centos"]
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {}
  }

  metadata = {
    ssh-keys = "kaanevran:${file("../keys/control-key.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "kaanevran"                 # Replace USERNAME
    private_key = file("../keys/control-key") # Path to your private key for SSH
    host        = self.network_interface.0.access_config.0.nat_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/kaanevran/keys"
    ]
  }



  provisioner "file" {
    source      = "../keys/"
    destination = "/home/kaanevran/keys/" # Replace USERNAME with the actual username
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/kaanevran/keys/*"
    ]
  }
  /*
  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y ansible > /var/log/ansible_install.log 2>&1
  EOF
  */
}

