terraform_apply:
	cd terraform/stage && terraform apply --auto-approve

terraform_destroy:
	cd terraform/stage && terraform destroy --auto-approve

packer_build_ui:
	packer build --var-file=packer/variables.json packer/ui.json

packer_build_db:
	packer build --var-file=packer/variables.json packer/db.json
