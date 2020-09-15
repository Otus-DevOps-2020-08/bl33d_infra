# bl33d_infra
bl33d Infra repository

# ДЗ № 4
## Multi-hop ssh connection

bastion_IP = 35.198.167.169
someinternalhost_IP = 10.156.0.3

**localworksation** -> **bastion** -> **someinternalhost**

Несколько различных вариантов подключения по ssh с **localwokrstation** на **someinternalhost** в одну команду:

### I. Использовать ключ -t:
```
ssh -i ~/.ssh/appuser -At appuser@84.201.133.173 ssh appuser@10.130.0.4
```
> -t  Force pseudo-terminal allocation.

### II. Использовать ключ -J:
```
ssh -i ~/.ssh/appuser -J appuser@84.201.133.173 appuser@10.130.0.4
```
> -J Connect to the target host by first making a ssh connection to the jump host described by destination and then establishing a TCP forwarding to the ultimate destination from there.
Multiple jump hops may be specified separated by comma characters.
This is a shortcut to specify a ProxyJump configuration directive.

### III. Включить настройки для конкретного хоста в ~/.ssh/config:
```
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
```
ssh someinternalhost
```
