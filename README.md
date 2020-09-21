# bl33d_infra

bl33d Infra repository

## ДЗ № 5

### Cloud Testapp

testapp_IP = 84.201.157.229
testapp_port = 9292

#### Вариант запуска с метаданными в формате User-Data Script

```bash
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1,ssh-keys="ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmY1Y+TWSK5hjzZpda8w34c0CXPUYK7QPSpYavE0G02YGNp8XOx9/yWaCwcpTPYhDtoyvB1St4ANd+u3Dl7vaTaItMJb0KCIv5WC3qB0Av0tC7Ejv3eEJtKh29dWTwtwH/l5dHR0Lar8hU21vX4WUF6lnSMg6YKAiq4YZXHz4+EhcG+duY+UIYRuC/6x8bI6sD18A6zwNPGkm0mK2gY6wBzqGXN+qEyOt+tFlDzld4p2QYW28vhTEdDqeo/pSBBku83Ag2+sUiyNjJ2zVccX4g/p1hzw+/dgYuNVttDqTF/BrzFxpcd9+BmZaWUHP4ccHIl5EQzbINQbmQuFlSLga9 appuser" \
--metadata-from-file user-data=install_reddit_app.sh
```

#### Вариант запуска с метаданными в формате Cloud Config Data

```bash
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=install_reddit_app.yaml
```

## ДЗ № 4

### Multi-hop ssh connection

bastion_IP = 84.201.133.173
someinternalhost_IP = 10.130.0.4

**localworksation** -> **bastion** -> **someinternalhost**

Несколько различных вариантов подключения по ssh с **localwokrstation** на **someinternalhost** в одну команду:

#### I. Использовать ключ -t

```bash
ssh -i ~/.ssh/appuser -At appuser@84.201.133.173 ssh appuser@10.130.0.4
```

> -t  Force pseudo-terminal allocation.

#### II. Использовать ключ -J

```bash
ssh -i ~/.ssh/appuser -J appuser@84.201.133.173 appuser@10.130.0.4
```

> -J Connect to the target host by first making a ssh connection to the jump host described by destination and then establishing a TCP forwarding to the ultimate destination from there.
Multiple jump hops may be specified separated by comma characters.
This is a shortcut to specify a ProxyJump configuration directive.

#### III. Включить настройки для конкретного хоста в ~/.ssh/config

```bash
Host bastion
    HostName 84.201.133.173
    User appuser
    IdentityFile ~/.ssh/appuser

Host someinternalhost
    HostName 10.130.0.4
    User appuser
    IdentityFile ~/.ssh/appuser
    ForwardAgent yes
    ProxyJump bastion
```

```bash
ssh someinternalhost
```
