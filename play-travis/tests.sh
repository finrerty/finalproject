#!/bin/bash
# install ansible for packer validate
sudo pip install --upgrade pip
sudo pip install ansible

#packer
cd infra
packer validate -var-file=packer/variables.json.example packer/app.json
packer validate -var-file=packer/variables.json.example packer/db.json
packer validate -var-file=packer/variables.json.example packer/ui.json

#install terraform & tflint
curl https://releases.hashicorp.com/terraform/0.12.8/terraform_0.12.8_linux_amd64.zip -o /tmp/terraform.zip
sudo unzip /tmp/terraform.zip terraform -d /usr/bin/
curl https://raw.githubusercontent.com/wata727/tflint/master/install_linux.sh | bash

#terraform stage
cd terraform/stage
terraform get && terraform init
tflint
terraform validate

#Install Ansible-lint
cd ../..
sudo pip install ansible-lint

#Ansible
ansible-lint -x 401 ansible/playbooks/*

#Install Docker linter
sudo wget -qO- https://get.haskellstack.org/ | sh
git clone https://github.com/hadolint/hadolint
cd hadolint
stack install
cd ..

#Docker tests
hadolint microservices/crawler/Dockerfile
hadolint microservices/ui/Dockerfile
