# rcmltb-base-image

Docker base image for rclone mirror leech telegram bot

## How to build: 

1. Create an account first on Docker Hub.

- https://hub.docker.com/

2. Create a new builder: 

```
docker buildx create --name mybuilder --use --bootstrap
```

3. Trigger the build (from same directory of Dockerfile): 

```
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t username/image:latest --push .
```

- username: Replaced with the username of your Docker Hub account.

- image: Replaced with the name you want to give to your Docker image.

4. Verify the build: 

```
docker buildx inspect <name>
```
**Note**: Building the Dockerfile is a heavy process, so you should have a capable computer or vps.
