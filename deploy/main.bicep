param location string = resourceGroup().location
param appServiceName string
param containerRegistryName string
param dockerImageNameTag string
param acrResourceGroupName string

var dockerImage = '${containerRegistryName}.azurecr.io/${dockerImageNameTag}'

module appService 'appservice.bicep' = {
  name: '${appServiceName}-app'  
  params: {
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
