# Финальный проект

## Введение

Данный проект предоставляет возможность разворота базового приложения на python3 одним из нескольких наборов инструментов. Пользователь может выбрать что-то наиболее удобное для себя.

С чего начать:

1. [Монолит](https://github.com/finrerty/finalproject#%D0%BC%D0%BE%D0%BD%D0%BE%D0%BB%D0%B8%D1%82):
2. [Микросервисы](https://github.com/finrerty/finalproject#%D0%BC%D0%B8%D0%BA%D1%80%D0%BE%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B):


### Монолит

#### Разворот приложения в облачной инфраструктуре
1. В папке infra/packer переименовать файл variables.json.example в variables.json и указать свои данные.
2. В папке infra/terraform/stage переименовать файл terraform.tfvars.example в terraform.tfvars, указать ваше имя проекта в GCP, путь к публичному ключу и приватному ключу.
3. В файле infra/ansible/environments/stage/inventory.gcp.yml указать свой проект и путь к service_account_file
4. В папке /ansible/environments/stage/inventory.gcp.yml указать свой проект и путь к service_accoun$
4. В папке infra/ansible/roles/app/vars/main переименовать файл rmq_secret.yml.example в rmq_secret.yml, указать свои логин-пароль для RabbitMQ

5. Перейти в папку infra и выполнить команду
```
make deploy_site
```
6. UI будет доступен по адресу, который выведет terraform под именем ui_external_ip на порту 8000

Для удаления всех компонентов приложения из вашего облачного сервиса можно использовать команду
```
make terraform_destroy
```

#### Разворот приложения локально с помощью Vagrant
1. В папке infra необходимо выполнить команду
```
make Vagrant up
```

### Микросервисы

#### Разворот приложения локально с помощью docker
1. Заходим в файл microservices/Makefile и подставляем ваше имя пользователя для Docker-образов UI и Crawler
2. Заходим в папку microservices/docker и переименовываем файл .env.example в .env
3. В файл .env ставим такое же имя пользователя, какое было установлено в пункте 1. Так же устанавливаем логин и пароль для RabbitMQ. Остальные параметры стоит изменять только в случае крайней необходимости
4. Переходим в папку microservices и выполняем команду
```
make docker_deploy_app
```
5. UI будет доступен по IP-адресу клиента, на котором выполнялись пункты 1-4 на порту UI_PORT, указанном в файле microservices/docker/.env

Для остановки всех контейнеров приложения можно использовать команды
```
make docker_compose_down
make docker_compose_down_logging
```

#### Разворот приложения на удалённой docker-machine (на примере GCP)
1. Создадим правило firewall'а в GCP для доступа к UI из интернета
```
gcloud compute firewall-rules create prometheus-default --allow tcp:8000
```
2. Создадим docker-host в GCP
- Укажем идентификатор проекта в переменную окружения GOOGLE_PROJECT
```
$ export GOOGLE_PROJECT=yourproject-123456
```
- Создадим виртуальную докер машину
```
$ docker-machine create --driver google \
--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
--google-machine-type n1-standard-1 \
--google-zone europe-west1-b docker-host
```

- Объясним локальной системе, что необходимо использовать удалённую машину для работы с Docker
```
$ eval $(docker-machine env docker-host)
```

3. Теперь выполним пункты с 1-го по 4-й из главы "Разворот приложения локально с помощью docker"

4. UI будет доступен по IP-адресу docker-host на порту UI_PORT, указанном в файле microservices/docker/.env

Для остановки всех контейнеров приложения можно использовать команду
```
make docker_compose_down
make docker_compose_down_logging
```

#### Разворот приложения локально с помощью kubernetes
1. При запущенном minikube выполняем команду
```
make kubernetes_apply
```

#### Разворот приложения в GCP с помощью kubernetes
1. Заходим в папку microservices/kubernetes/terraform. Переименовываем terraform.tfvars.example в terraform.tfvars. Указываем свой проект.
2. Заходим в Makefile и так же указываем своё название проекта. Выполняем команду
```
make kubernetes_deploy_app
```

### Логирование

На данном этапе система логирования доступна при использовании для разворота приложения способов с docker и docker-machine  
После создания инструменты доступны по следующим портам
```
#Kibana
localhost:5601/docker-machine:5601

#Zipkin
localhost:9411/docker-machine:9411
```
