# Nginx Proxy
This provides a basic example for using [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy?tab=readme-ov-file) with [acme-companion](https://github.com/nginx-proxy/acme-companion) to enable simple reverse proxy configurations with automatic SSL support via Let's Encrypt.

The `nginx-proxy` sets up a container running nginx and docker-gen. docker-gen generates reverse proxy configurations for nginx and automatically reloads nginx when Docker containers are started and stopped. This setup helps in dynamically adjusting nginx based on the active containers.

The `acme-companion` extends this setup by automatically creating and renewing SSL certificates from Let's Encrypt, applying them to the configurations created by docker-gen.
