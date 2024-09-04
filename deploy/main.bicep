param location string = resourceGroup().location
param appServiceName string = 'loeme-staging'
param containerRegistryName string = 'latzo'
param dockerImageNameTag string = 'latest'
param acrResourceGroupName string = 'rg-acr-prod-001'

@secure()
param WEATHER_API_KEY string = newGuid()

@secure()
param GOOGLE_PLACES_API_KEY string = newGuid()

var dockerImage = '${containerRegistryName}.azurecr.io/loeme:${dockerImageNameTag}'

module appService 'appservice.bicep' = {
  name: '${appServiceName}-app'  
  params: {
    WEATHER_API_KEY: WEATHER_API_KEY
    GOOGLE_PLACES_API_KEY: GOOGLE_PLACES_API_KEY
    appServiceName: appServiceName    
    location:   location
    dockerImage: dockerImage
  }
}

module roleAssignment 'roleassignment.bicep' = {
  name: '${appServiceName}-roleassignment'  
  scope: resourceGroup(acrResourceGroupName)
  params: {
    appServicePrincipalId: appService.outputs.principalId
    containerRegistryName: containerRegistryName
  }
}
