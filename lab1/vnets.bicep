param location string = 'southcentralus'

var vnets  = [
  {
    name: 'labhub'
    addressPrefixes: '10.20.0.0/16'
    subnetName: 'sn-pri-001'
    subnetPrefix: '10.20.0.0/24'
  }
  {
    name: 'labspk1'
    addressPrefixes: '10.21.0.0/16'
    subnetName: 'sn-pri-002'
    subnetPrefix: '10.21.0.0/24'
  }
  {
    name: 'labspk2'
    addressPrefixes: '10.22.0.0/16'
    subnetName: 'sn-pri-003'
    subnetPrefix: '10.22.0.0/24'
  }
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = [for vnet in vnets: {
  name: vnet.name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefixes
      ]
    }
    subnets: [
      {
        name: vnet.subnetName
        properties: {
          addressPrefix: vnet.subnetPrefix
        }
      }
   ]
  }
}]


resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = [for net in vnets: {
  name: '${net.name}/peering${net.name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: virtualNetwork[0].id
    }
  }
}]

// resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
//   name: 'labhub/hub2spk2'
//   properties: {
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: true
//     allowGatewayTransit: true
//     useRemoteGateways: false
//     remoteVirtualNetwork: {
//       id: vnets[2].id
//     }
//   }
// }

// resource peering3 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
//   name: 'labspk1/spk12hub'
//   properties: {
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: true
//     allowGatewayTransit: true
//     useRemoteGateways: false
//     remoteVirtualNetwork: {
//       id: vnets[0].id
//     }
//   }
// }

// resource peering4 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
//   name: 'labspk2/spk22hub'
//   properties: {
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: true
//     allowGatewayTransit: true
//     useRemoteGateways: false
//     remoteVirtualNetwork: {
//       id: vnets[0].id
//     }
//   }
// }
