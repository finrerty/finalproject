build_ui:
	cd ui && docker build -t finrerty/ui:latest .

build_crawler:
	cd crawler && docker build -t finrerty/crawler:latest .

docker_compose_up:
	cd docker && docker-compose up -d

docker_compose_down:
	cd docker && docker-compose down

deploy_app: build_ui build_crawler docker_compose_up
