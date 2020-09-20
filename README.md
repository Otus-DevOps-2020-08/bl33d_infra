# bl33d_infra

bl33d Infra repository

## ДЗ № 6

### Cloud Testapp

testapp_IP = TBD
testapp_port = TBD

## ДЗ № 5

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
