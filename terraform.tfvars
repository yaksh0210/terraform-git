# # Resource Group Details

# resource_group_name = ""
# location            = "southeastasia"

# # Vm configuration

# vm_name = "devops-vm"
# vm_size = "Standard_B2s"


# ip_configuration_name = "internal"


# # Networking section

# vnet_name                     = "vnet-demo"
# subnet_name                   = "subnet-demo"
# private_ip_address_allocation = "Dynamic"
# nic_name                      = "nic-demo"



# -----------------------------
# Resource Group
# -----------------------------

resource_group_name = "sa1_test_eic_YakshRawal"
location            = "southeastasia"

# -----------------------------
# VM Configuration
# -----------------------------

vm_name        = "devops-vm"
vm_size        = "Standard_B2s"
admin_username = "azureuser"
admin_password = "Test@1234567"

# -----------------------------
# Networking
# -----------------------------

vnet_name             = "vnet-demo"
subnet_name           = "subnet-demo"
nic_name              = "nic-demo"
ip_configuration_name = "internal"
