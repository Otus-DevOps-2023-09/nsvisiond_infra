# nsvisiond_infra

### Исследовать способ подключения someinternalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и внести его в README.md в вашем репозитории

**Решение**:
``ssh -J appuser@51.250.77.142 appuser@10.128.0.14``

https://disk.yandex.ru/i/ZnjiFBCgbC8nZQ

### Предложить вариант решения для подключения из консоли при помощи команду вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost и внести его в README.md в
вашем репозитории

В `~/.ssh/config`
добавляем

```
Host someinternalhost
  HostName 10.128.0.14
  User appuser
  IdentityFile ~/.ssh/id_rsa

  ProxyJump appuser@51.250.77.142
  ```

https://disk.yandex.ru/i/r6sKiN9RzOdgbQ

### Опишите в README.md и получившуюся конфигурацию и данные для  подключения в следующем формате (важно для проверки!)

**Pritunl**: https://otus.srv-dev.ru/login


```
bastion_IP = 51.250.77.142
someinternalhost_IP = 10.128.0.14
```

### Добавьте информацию о данном ДЗ в README.md и впишите данные для подключения в следующем формате (важно для автоматической проверки ДЗ), не удаляя предыдущую

```
testapp_IP = 51.250.90.84
testapp_port = 9292
```

### В качестве доп. задания используйте созданные ранее скрипты для создания startup script , который будет запускаться при создании инстанса.

```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data="/Users/kirk/PycharmProjects/nsvisiond_infra/startup_script.sh" \
  --metadata serial-port-enable=1
```
### ДЗ 5. Сборка образов VM при помощи Packer

- создана ветка packer-base
- наработки предыдущего ДЗ перенесены в config-scripts
- установлен Packer
- создан сервисный аккаунт с соответствующими правами
- собран baked-образ с Ruby и MongoDB (reddit-base, конфиг ubuntu16.json)
- из образа вручную создана VM и задеплоено приложение
- произведена параметризация настроек через variables.json
- создан образ с задеплоенным приложением reddit (reddit-full, конфиг immutable.json)
- создан скрипт create-reddit-vm.sh для создания VM с запущенным приложением через Yandex.Cloud CLI

### ДЗ 6. Практика IaC с использованием Terraform

- создана ветка terraform-1
- установлен Terraform
- создана VM по описанию в файле main.tf
- настройки переменных вынесены в файл outputs.tf
- настроены provisioners для запуска приложения после сборки VM
- в конфигурацию lb.tf добавлен балансировщик
- в конфигурации добавлены настройки для работы параметра count, чтобы создавать произвольное кол-во VM и добавлять их автоматически в балансировщик

### ДЗ 7. Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform.

- создана ветка terraform-2
- подчистил прошлые задания со *
- создал отдельные образы для MongoDB и Ruby с помощью Packer
- разбил конфигурации сред на stage и prod
- конфигурации сетей, БД и приложения выделил в отдельные модули. каждая среда запускается в своей сетке
- настроил хранение state в Yandex Object Storage, состояние lock удалённо хранится в DynamoDB
- добавил настройки для запуска provisioners по условию наличия переменной need_provisioning, если она true - приложение сразу запускается
- дополнительно создал bash скрипт terraform/init/init.sh, который проводит все подготовительные инициализации в автоматическом режиме. В консоли и веб-интерфейсе делать ничего не нужно.

### ДЗ 8. Управление конфигурацией. Основные DevOps инструменты. Знакомство с Ansible.

- создана ветка ansible-1
- установлен ansible
- запущены stage сервера через terraform
- попрактиквался с inventory разных форматов
- попрактиковался поуправлять сервером через команды ansible
- попрактиковался писать playbook
- создал динамический inventory с помощью bash-файла

### ДЗ 9. Деплой и управление конфигурацией с Ansible.

- создана ветка ansible-2
- поигрался вариантами плейбуков: один playbook - один сценарий, один плейбук - несколько сценариев, несколько плейбуков
- переделал динамическую инвентаризацию на inventory plugin
- изменил provisioning в packer на ansible
- пересобрал образы
