USERNAME = finrerty
PROJECTNAME = finalproject-266411

build_ui:
	cd ui && docker build -t $(USERNAME)/ui:latest .

build_crawler:
	cd crawler && docker build -t $(USERNAME)/crawler:latest .

build_fluentd:
	cd logging/fluentd/ && docker build -t $(USERNAME)/fluentd:latest .

docker_compose_up_monitoring:
        cd docker && docker-compose -f docker-compose-monitoring.yml up -d

docker_compose_down_monitoring:
        cd docker && docker-compose -f docker-compose-monitoring.yml down

docker_compose_up_logging:
	cd docker && docker-compose -f docker-compose-logging.yml up -d

docker_compose_down_logging:
	cd docker && docker-compose -f docker-compose-logging.yml down

docker_compose_up:
	cd docker && docker-compose up -d

docker_compose_down:
	cd docker && docker-compose down

docker_deploy_app: build_ui build_crawler build_fluentd docker_compose_up_logging docker_compose_up docker_compose_up_monitoring

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
