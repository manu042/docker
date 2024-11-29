# Hetzner

Cloud config:
```yaml
#cloud-config
packages:
  - zsh
  - docker.io
  - docker-compose
package_update: true
package_upgrade: true
runcmd:
    - sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    - reboot
```
