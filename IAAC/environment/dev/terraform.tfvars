rgs = {
  rg1 = {
    name     = "rg-tf1"
    location = "West Europe"
  }
  rg2 = {
    name     = "rg-tf2"
    location = "West Europe"
  }
}
vnets = {
  vnet1 = {
    name          = "vnet1"
    location      = "West Europe"
    rg_key        = "rg1"
    address_space = ["10.0.0.0/16"]

  }
  vnet2 = {
    name          = "vnet2"
    location      = "Central India"
    rg_key        = "rg2"
    address_space = ["10.19.0.0/16"]
  }
}
nsgs = {
  nsg1 = {
    name     = "nsg1"
    location = "West Europe"
    rg_key   = "rg1"
  }
  nsg2 = {
    name     = "nsg2"
    location = "Central India"
    rg_key   = "rg2"
  }
}
subnets = {
  subnet1 = {
    name             = "subnet1"
    rg_key           = "rg1"
    vnet_key         = "vnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "subnet2"
    rg_key           = "rg2"
    vnet_key         = "vnet2"
    address_prefixes = ["10.19.1.0/24"]
  }
}

nic_nsg1 = {
  nsg_key = "nsg1"
}
nic_nsg2 = {
  nsg_key = "nsg2"
}

pip = {
  name              = "pip-test"
  location          = "West Europe"
  rg_key            = "rg2"
  allocation_method = "Static"
  sku               = "Standard"
}
nic1 = {
  name              = "web-nic"
  location          = "West Europe"
  rg_key            = "rg1"
  public_ip_enabled = true

  ip_configuration = {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
  }
}

nic2 = {
  name              = "app-nic"
  location          = "Central India"
  rg_key            = "rg2"
  public_ip_enabled = false

  ip_configuration = {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
  }
}

vm1name = {
  name           = "web-vm"
  location       = "West Europe"
  rg_key         = "rg1"
  vm_size        = "Standard_D2s_v3"
  admin_username = "testadmin"
  admin_password = "Password1234!"
}
osdiskname = {
  name                 = "osdisk"
  caching              = "ReadWrite"
  create_option        = "FromImage"
  storage_account_type = "Standard_LRS"
}

vm2name = {
  name           = "app-vm"
  location       = "Central India"
  rg_key         = "rg2"
  vm_size        = "Standard_B2als_v2"
  admin_username = "testadmin"
  admin_password = "Password1234!"
}
datadiskname = {
  name                 = "datadisk"
  caching              = "ReadWrite"
  create_option        = "FromImage"
  storage_account_type = "Standard_LRS"
}
peering = {
  rg_key1   = "rg1"
  rg_key2   = "rg2"
  vnet_key1 = "vnet1"
  vnet_key2 = "vnet2"
  vnet_id1  = "vnet1"
  vnet_id2  = "vnet2"
}
ssh = {
  ssh1 = {
    rg_key  = "rg1"
    nsg_key = "nsg1"
  }
  ssh2 = {
    rg_key  = "rg2"
    nsg_key = "nsg2"
  }
}
http = {
  http1 = {
    rg_key  = "rg1"
    nsg_key = "nsg1"
  }
  http2 = {
    rg_key  = "rg2"
    nsg_key = "nsg2"
  }
}