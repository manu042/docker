# Nginx Proxy
This provides a basic example for using [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy?tab=readme-ov-file) with [acme-companion](https://github.com/nginx-proxy/acme-companion) to enable simple reverse proxy configurations with automatic SSL support via Let's Encrypt.

The `nginx-proxy` sets up a container running nginx and docker-gen. docker-gen generates reverse proxy configurations for nginx and automatically reloads nginx when Docker containers are started and stopped. This setup helps in dynamically adjusting nginx based on the active containers.

The `acme-companion` extends this setup by automatically creating and renewing SSL certificates from Let's Encrypt, applying them to the configurations created by docker-gen.



## Setup 
This setup uses the [separate container](https://github.com/nginx-proxy/nginx-proxy/tree/main/docs#separate-containers) config to not have the docker socket bound to a publicly exposed container.

In this config it is necessary to have the file [nginx.tmpl](https://github.com/nginx-proxy/nginx-proxy/blob/main/nginx.tmpl) on the host system.

To download the newest version of nginx.tmpl use this command:
```shell
curl -O https://raw.githubusercontent.com/nginx-proxy/nginx-proxy/main/nginx.tmpl
```

Then start the nginx-proxy with docker compose:
```shell
docker compose up -d
```


## Basic Authentication Support
To add Basic Authentication create a file named as its equivalent VIRTUAL_HOST in directory `/etc/nginx/htpasswd/{$VIRTUAL_HOST}` and restart `nginx` and `dockergen`.

1. Install `apache2-utils`:
```shell
sudo apt-get install --dry-run apache2-utils
```

2. Create a new username and password entry for your `{$VIRTUAL_HOST}` e.g. example.com:
```shell
sudo htpasswd -c -B /etc/nginx/htpasswd/example.com username
```

For more information see [Basic Authentication Support](https://github.com/nginx-proxy/nginx-proxy/tree/main/docs#basic-authentication-support)
