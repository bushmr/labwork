param location string 
param lbname string 
param vmssName string 
param vmSize string 
param adminName string 
@secure()
param adminPass string
param vmNamePfx string 
param vnet string 
param subnet0 string 
param subnet1 string 
param subnet2 string 

resource alb 'Microsoft.Network/loadBalancers@2022-01-01' ={
  name: lbname
  location: location
  sku:  {
     name: 'Standard'
  }
  properties: {
   frontendIPConfigurations: [
    {
       name: 'feip-${vmNamePfx}'
       properties: {
         privateIPAllocationMethod: 'Dynamic'
         subnet: {
         id: resourceId('Microsoft.Network/virtualNetworks/subnets', '${vnet}', '${subnet1}')
         }
        }
    }
   ]
   backendAddressPools: [
    {
       name: 'beap-${vmNamePfx}'
       properties: {
         
       }
    }
   ]
    
   }

}

resource scaleSet 'Microsoft.Compute/virtualMachineScaleSets@2022-03-01' = {
  location: location
  name: vmssName
  
  sku: {
    capacity: 1
    name: vmSize
  }
  
  plan: {
    name: 'f5-big-all-2slot-byol'
    publisher: 'f5-networks'
    product: 'f5-big-ip-byol'
  }
  zones: [ '3']
  
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
               enableAcceleratedNetworking: false
               deleteOption: 'Delete'
               primary: true
               ipConfigurations: [
                {
                  name: 'ipconfig0' 
                  properties: {
                     primary: true
                     subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet2}')
                    }
                  }
                }
              ]
            }
          }
          {
            name: 'nic1'
            properties: {
             enableAcceleratedNetworking: true
             deleteOption: 'Delete'
             ipConfigurations: [
              {
                name: 'ipconfig1' 
                properties: {
                    subnet: {
                    id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet1}')
                    }
                    publicIPAddressConfiguration:{
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
            name: 'nic2'
            properties: {
             enableAcceleratedNetworking: false
             deleteOption: 'Delete'
             ipConfigurations: [
              {
                name: 'ipconfig2' 
                properties: {
                    subnet: {
                    id: resourceId('Microsoft.Network/virtualNetworks/subnets','${vnet}', '${subnet0}')
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
