# LibreChat
LibreChat is a chatbot interface for the OpenAI API.
- https://www.librechat.ai/
- https://github.com/danny-avila/LibreChat



## Setup
1. Start services
```
docker-compose up -d
```

2. Add LibreChat container to bridge network
```
docker network connect bridge LibreChat
```

3. Restart nginx-proxy container
```
docker restart nginx-proxy
```


## Create User
1. Execute container shell 
```
docker exec -it LibreChat sh
```
2. Run `create-user` script
```
npm run create-user
```

https://www.librechat.ai/docs/configuration/authentication#create-user-script



