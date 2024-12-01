# LibreChat
LibreChat is a chatbot interface for the OpenAI API.
- https://www.librechat.ai/
- https://github.com/danny-avila/LibreChat



## Setup
1. Create and edit `.env` file
2. (Generate Credentials)[https://www.librechat.ai/toolkit/creds_generator] and add them to the `.env` file
3. Start services
```
docker-compose up -d
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
