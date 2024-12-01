# Hetzner

https://community.hetzner.com/tutorials/basic-cloud-config/de

Cloud config:
```yaml
#cloud-config
users:
  - name: holu
    groups: users, admin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - <public_ssh_key>

packages:
  - zsh
package_update: true
package_upgrade: true
```
