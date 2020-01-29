terraform_apply:
	cd terraform/stage && terraform apply --auto-approve

terraform_destroy:
	cd terraform/stage && terraform destroy --auto-approve

packer_build_app:
	packer build --var-file=packer/variables.json packer/app.json

packer_build_ui:
	packer build --var-file=packer/variables.json packer/ui.json

packer_build_db:
	packer build --var-file=packer/variables.json packer/db.json

ansible_play_db:
	cd ansible && ansible-playbook playbooks/db.yml

ansible_play_ui:
	cd ansible && ansible-playbook playbooks/ui.yml

ansible_play_site:
	cd ansible && ansible-playbook playbooks/site.yml

deploy_site: terraform_apply ansible_play_site
