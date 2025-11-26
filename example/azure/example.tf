
provider "azurerm" {
  features {}
}


module "labels" {
  source = "../../"

  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-modules"
  attributes  = ["v1"]
  extra_tags = {
    Owner      = "Rahul Yadav"
    CostCenter = "Finance"
  }
}

resource "azurerm_resource_group" "test" {
  name     = module.labels.id
  location = "eastus"
  tags     = module.labels.tags
}