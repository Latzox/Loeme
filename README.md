[![Build and Push to ACR (Staging)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-staging.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-staging.yml)
[![Build and Push to ACR (Prod)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-prod.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/docker-build-prod.yml)
[![Latest Bicep Deployment](https://github.com/Latzox/Loeme/actions/workflows/bicep-deploy.yml/badge.svg)](https://github.com/Latzox/Loeme/actions/workflows/bicep-deploy.yml)

# Introduction 
Loeme is a web application written in html/css and python. You can search your city and get a 3-day weather forecast as well as informations about points of interests in that city and restaurants and hotels which are worth a look.

# Getting Started
1.	Installation process
2.	Software dependencies
3.	Latest releases

## Installation process
### Docker
You can pull the current docker image from Azure Container Registry. But you need to authenticate. Ask the developer for access.
```
docker login latzo.azurecr.io
```
Then you can pull the latest image
```
docker pull latzo.azurecr.io/loeme:latest
```
And run the application with:
```
docker run -n web -p 80:80 latzo.azurecr.io/loeme:latest
```

### Python
If you'd like to run the app in your local python environment, you can follow these steps:
```
Todo
```


# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)