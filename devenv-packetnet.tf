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

# TODO: Switch to ARMv8 after resolving Docker install issues
#  plan = "baremetal_2a"
  plan = "baremetal_0"

  facility = "sjc1"
  operating_system = "ubuntu_16_04"
  billing_cycle = "hourly"
  project_id = "${packet_project.solo5-devenv.id}"

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file("packnet.pem")}"
  }

  # Transfer files onto the target system in case execution during terraform build doesn't
  # go entirely to plan
  provisioner "file" {
    source = "setup-docker.sh"
    destination = "/root"
  }
  provisioner "file" {
    source = "setup-kvm.sh"
    destination = "/root"
  }
  provisioner "file" {
    source = "setup-solo5.sh"
    destination = "/root"
  }

  provisioner "remote-exec" {
    script = "setup-docker.sh"
  }
  provisioner "remote-exec" {
    script = "setup-kvm.sh"
  }
  provisioner "remote-exec" {
    script = "setup-solo5.sh"
  }
}

output "server_ip" {
    value = "${packet_device.network}"
}
