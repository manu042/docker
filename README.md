# Docker
For details on configuring services in Docker Compose, check out https://docs.docker.com/reference/compose-file/services/



## Docker commands
List Docker containers in a more readable format:
```shell
$ docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"
```
Refer to https://docs.docker.com/go/formatting/ for more information about formatting


Remove all stopped containers:
```shell
$ docker container prune
```


Monitor container resource usage:
```shell
$ docker stats
```


Use environment variables with Docker Compose:
```shell
# 1. Reference a environment variable to a service: DB_PASSWORD=${DB_PASSWORD}
# 2. Add variable to .env file: DB_PASSWORD=mysecretpassword

$ docker-compose --env-file custom.env up -d
```

Show Docker image layers:
```shell
$ docker history [image_name:tag]

$ docker history lscr.io/linuxserver/code-server:latest --format "table{{.CreatedBy}}\t{{.Size}}"
```
