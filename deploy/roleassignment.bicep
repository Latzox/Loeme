param containerRegistryName string = 'latzo'
param appServicePrincipalId string = 'Dummy'

// Existing container registry reference
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: containerRegistryName
}

// acrPullDefinitionId is AcrPull
var acrPullDefinitionId = '7f951dda-4ed3-4680-a7ca-43fe172d538d'

// Role assignment to allow ACR pull
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(containerRegistry.id, appServicePrincipalId, 'AcrPullSystemAssigned')
  scope: containerRegistry
  properties: {
    principalId: appServicePrincipalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', acrPullDefinitionId)
  }
}
