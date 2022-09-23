
param location string = 'southcentralus'
param vmssName string = 'vmssf5'
param adminName string = 'cadmin'
@secure()
param adminPass string
param vmNamePfx string = 'f5lb'
param vnet string = 'vnet007'
param subnet0 string = 'int'
param subnet1 string = 'ext'
param subnet2 string = 'mgmt'

resource scaleSet 'Microsoft.Compute/virtualMachineScaleSets@2022-03-01' = {
  location: location
  name: vmssName
  
  sku: {
    capacity: 1
    name: 'Standard_F2s_v2'
  }
  
  plan: {
    name: 'f5-big-all-2slot-byol'
    publisher: 'f5-networks'
    product: 'f5-big-ip-byol'
  }
  zones: [ '1', '2', '3' ]
  
  properties: {
    orchestrationMode: 'Flexible'
    platformFaultDomainCount: 1
    virtualMachineProfile: {
      osProfile: {
        adminUsername: adminName
        adminPassword: adminPass
        computerNamePrefix: vmNamePfx
      }
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Standard_LRS'
          }
        }
        imageReference: {
          publisher: 'f5-networks'
          offer: 'f5-big-ip-byol'
          sku: 'f5-big-all-2slot-byol'
          version: 'latest'
        }
      }
      networkProfile: {
        networkApiVersion: '2020-11-01'
        networkInterfaceConfigurations: [
          {
            name: 'nic0'
              properties: {
               enableAcceleratedNetworking: true
               deleteOption: 'Delete'
               primary: true
               ipConfigurations: [
                {
                  name: 'ipconfig0' 
                  properties: {
                     primary: true
                     subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet0}')
                    }
                    publicIPAddressConfiguration: {
                      name: 'pubIpConfig0'
                      properties: {
                        deleteOption: 'Delete'
                      }
                      sku: {
                        name: 'Standard'
                      }
                    }
                   }
                }
              ]
            }
          }
          {
            name: 'nic1'
            properties: {
             enableAcceleratedNetworking: false
             deleteOption: 'Delete'
             ipConfigurations: [
              {
                name: 'ipconfig0' 
                properties: {
                    subnet: {
                    id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet1}')
                  }
                 }
              }
            ]
           }
          }
          {
            name: 'nic2'
            properties: {
             enableAcceleratedNetworking: false
             deleteOption: 'Delete'
             ipConfigurations: [
              {
                name: 'ipconfig0' 
                properties: {
                    subnet: {
                    id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet2}')
                  }
                 }
              }
            ]
           }
          }
        ]
       }
      }
    }
  }
