## Resource Groups
resgrp = {
  network = {
    resgrp_name     = "network"
  }
  container = {
    resgrp_name     = "container"
  }
  registry = {
    resgrp_name     = "registry"
  }
}

## Network
vnets = {
  app = {
    vnet_name     = "app"
    address_space = ["10.30.0.0/20"]
  }
  data = {
    vnet_name     = "data"
    address_space = ["10.30.16.0/20"]
  }
  devops = {
    vnet_name     = "devops"
    address_space = ["10.30.112.0/20"]
  }
}

subnets = {
  apim = {
    vnet_name        = "app"
    subnet_name      = "apim"
    address_prefixes = ["10.30.2.0/23"]
  }
  gway = {
    vnet_name        = "app"
    subnet_name      = "gway"
    address_prefixes = ["10.30.15.0/24"]
  }
  agents = {
    vnet_name        = "devops"
    subnet_name      = "agents"
    address_prefixes = ["10.30.112.0/24"]
  }
  db = {
    vnet_name        = "data"
    subnet_name      = "db"
    address_prefixes = ["10.30.16.0/24"]
  }
}

containerregistries = {
  thadelmsdevcr = {
    cr_name = "thadelmsdevcr"
  }

  #   thadelmsprdcr = {
  #     cr_name = "thadelmsprdcr"
  #   }
}


# containerapps = {
#   quoteapi = {
#     quoteapi_name = "quoteapi"
#     subnet_name    = "apim"
#     registry_image = "quoteapi"
#   }
#   policyapi = {
#     quoteapi_name = "quoteapi"
#     subnet_name    = "apim"
#     registry_image = "quoteapi"
#   }
# }

