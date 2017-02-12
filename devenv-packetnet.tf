variable "auth_token" {
  type = "string"
}

# Configure the Packet Provider
provider "packet" {
  auth_token = "${var.auth_token}"
}

# Create a project
resource "packet_project" "solo5-devenv" {
  name = "Solo5 Development Environment"
}

# Create a Ubuntu developement machine and install base packages
resource "packet_device" "solo5-dev" {
  hostname = "solo5-dev"
  plan = "baremetal_0"
  facility = "nrt1"
  operating_system = "ubuntu_16_04"
  billing_cycle = "hourly"
  project_id = "${packet_project.solo5-devenv.id}"

  provisioner "remote-exec" {
    script = "setup-docker.sh"
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("packnet.pem")}"
    }
  }
  provisioner "remote-exec" {
    script = "setup-kvm.sh"
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("packnet.pem")}"
    }
  }
}

