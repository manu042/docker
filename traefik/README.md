# Traefik

## Authelia Config
Generate a user password:
```bash
docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password 'yourpassword'
```

Generate `encryption_key` and a `jwt_secret`:
```bash
# encryption_key
docker run -it --rm authelia/authelia:latest authelia crypto rand --length 64 --charset alphanumeric

# jwt_secret
docker run -it --rm authelia/authelia:latest authelia crypto jwt generate --random --length 32
```

Alternatively you can use openssl:
```bash
openssl rand -base64 32     # for jwt_secret
openssl rand -base64 64     # for encryption_key
```

## Read Authelia notifications
```bash
docker exec -it authelia cat /config/notification.txt
```
