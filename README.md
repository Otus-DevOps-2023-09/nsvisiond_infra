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
