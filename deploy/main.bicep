param location string = resourceGroup().location
param appServiceName string
param containerRegistryName string
param dockerImageNameTag string
param acrResourceGroupName string

@secure()
param WEATHER_API_KEY string

@secure()
param GOOGLE_PLACES_API_KEY string

var dockerImage = '${containerRegistryName}.azurecr.io/${dockerImageNameTag}'

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
