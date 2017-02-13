Overview
========
This repository contains automation to establish a development environment for Solo5 & kvm on both amd64 and aarch64 architectures. It makes use of the https://packet.net baremetal servers and https://terraform.io orchestration tooling.

Setup Steps
-----------

1. Create an ssh key in top level project directory

    ```bash
    ssh-keygen -t rsa -f packnet.pem
    ```

1. Follow the steps in the [packet.net quickstart guide](https://packet.freshdesk.com/en/support/solutions/articles/22000170195-quick-start-guide) substituting the above key.

1. Generate a new API key using [packet.net console api-keys](https://app.packet.net/portal/#/api-keys/new)

1. Save the "token" value of the API key into a file named terraform.tfvars
    ```bash
       echo auth_token="<your token here>" > terraform.tfvars
    ```

1. Install terraform

    ```bash
    brew install terraform
    ```

1. Check terraform execution without creating any resources
    ```bash
     terraform plan
    ```

1. Create a server in packet.net and provision with the base tools needed for solo5 development.
    ```bash
     terraform apply
    ```

1. Ssh onto your new box and do wonderful KVM/Solo5 development in a repeatable environment.  NB: if the installation does not work perfectly the setup scripts are in /root and can be tweaked/executed manually.


References
----------

* http://blog.alexellis.io/get-started-with-docker-on-64-bit-arm/
* https://docs.docker.com/engine/getstarted/step_one/
* https://help.ubuntu.com/community/KVM/Installation
