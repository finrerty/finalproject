# Финальный проект

## Введение

Цели данного проекта исключительно учебные. Главная идея - задействование как можно большего количества изученных за последние 4 месяца инструментов. Работа разделена на 2 части: монолитное приложение (основные инструменты: packer, terraform, ansible) и микросервисное (основные инструменты: docker, kubernetes).

С чего начать:

1. [Монолит](Монолит):
2. [Микросервисы](Микросервисы):


### Монолит

1. В папке monolith/packer переименовать файл variables.json.example в variables.json и указать свои данные.
2. В папке monolith/terraform/stage переименовать файл terraform.tfvars.example в terraform.tfvars, указать ваше имя проекта в GCP, путь к публичному ключу и приватному ключу.
3. В файле monolith/ansible/environments/stage/inventory.gcp.yml указать свой проект и путь к service_account_file

### Микросервисы
