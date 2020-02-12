#!/bin/bash
# install ansible for packer validate
sudo pip install --upgrade pip
sudo pip install ansible

#packer
packer validate -var-file=infra/packer/variables.json.example infra/packer/app.json
packer validate -var-file=infra/packer/variables.json.example infra/packer/db.json
packer validate -var-file=infra/packer/variables.json.example infra/packer/ui.json
