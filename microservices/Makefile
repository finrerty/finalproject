USERNAME = finrerty
PROJECTNAME = finalproject-266411

build_ui:
	cd ui && docker build -t $(USERNAME)/ui:latest .

build_crawler:
	cd crawler && docker build -t $(USERNAME)/crawler:latest .

docker_compose_up:
	cd docker && docker-compose up -d

docker_compose_down:
	cd docker && docker-compose down

docker_deploy_app: build_ui build_crawler docker_compose_up

terraform_create_kubernetes_cluster:
	cd kubernetes/terraform && terraform apply --auto-approve

terraform_detroy_kubernetes_cluster:
	cd kubernetes/terraform && terraform destroy --auto-approve

kubernetes_get_cluster_context:
	gcloud container clusters get-credentials finalproject-cluster --zone europe-west1-b --project $(PROJECTNAME)

kubernetes_apply:
	cd kubernetes && kubectl apply -f . -n dev

kubernetes_delete:
	cd kubernetes && kubectl delete -f . -n dev

kubernetes_deploy_app: terraform_create_kubernetes_cluster kubernetes_get_cluster_context kubernetes_apply
