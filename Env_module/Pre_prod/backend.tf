terraform {
  backend "azurerm" {
    resource_group_name  = "mahesh_rg"
    storage_account_name = "maheshbknd"
    container_name       = "tfstate"
    key                  = "pre-prod.terraform.tfstate"
    use_oidc             = true
  }
}
