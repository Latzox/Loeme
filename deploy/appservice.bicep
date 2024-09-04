param location string = resourceGroup().location
param appServiceName string = 'loeme-staging'
param dockerImage string = 'latzo.azurecr.io/loeme:latest'

@secure()
param WEATHER_API_KEY string = newGuid()

@secure()
param GOOGLE_PLACES_API_KEY string = newGuid()

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: toLower('${appServiceName}-asp')
  location: location
  kind: 'linux'
  sku: {
    name: 'B1'
  }
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: '${appServiceName}-app'
  location: location
  kind: 'app,linux,container'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${dockerImage}'
      acrUseManagedIdentityCreds: true
      appSettings: [
        {
          name: 'WEATHER_API_KEY'
          value: WEATHER_API_KEY
        }
        {
          name: 'GOOGLE_PLACES_API_KEY'
          value: GOOGLE_PLACES_API_KEY
        }
      ]
    }
  }
}

output principalId string = appService.identity.principalId
output appServiceResourceName string = appService.name
