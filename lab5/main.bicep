param vNetName string 
param fwPolName string
param fwName string
param location string = resourceGroup().location
param fwPip string


resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' existing = {
   name: vNetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' existing = {
   name: 'AzureFirewallSubnet'
   parent: vnet
}

resource fwPubIp 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
   name: fwPip 
   location: location
   sku: {
     name: 'Standard'
    
   }
    properties: {
       publicIPAllocationMethod: 'Static'
    }
}

resource azfwpol 'Microsoft.Network/firewallPolicies@2022-01-01' = {
   name: fwPolName 
   location: location
    properties: {
       sku: {
         tier: 'Premium'
       }
        intrusionDetection: {
           mode: 'Alert'
        }
        threatIntelMode: 'Alert'
    }
}

resource azfw 'Microsoft.Network/azureFirewalls@2022-01-01' = {
   name: fwName
   location: location
   properties: {
      sku: {
         tier: 'Premium'
      }
      firewallPolicy:  {
         id: azfwpol.id
       }
      ipConfigurations: [
           {
             name: 'ipConfig1'
             properties: {
              publicIPAddress: {
                 id: fwPubIp.id
              } 
              subnet: {
                 id: subnet.id
               }
             }
           }
      ]
   }
}
