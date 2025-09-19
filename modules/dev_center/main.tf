module "vNet" {
  source = "../virtual_network"

  vnet_name           = "${var.vnet_name}-dev_center"
  resource_group_name = var.resource_group_name  

  subscription_id = var.subscription_id
  location        = var.location

  address_space     = var.address_space
  address_prefixes  = var.address_prefixes
}

resource "azurerm_dev_center" "this" {
  name = var.dev_center_name

  location              = var.location
  resource_group_name   = var.resource_group_name

  tags = merge(var.tags, { service = "dev_center" })
}
#Integración con VNet
resource "azurerm_dev_center_network_connection" "this" {
  name                = "${var.dev_center_name}-dcnc"

  resource_group_name = azurerm_dev_center.this.resource_group_name
  location            = azurerm_dev_center.this.location

  domain_join_type    = "AzureADJoin"
  subnet_id           = module.vNet.subvNet_id

  tags = merge(var.tags, { service = "dev_center_network_connection" })
}
resource "azurerm_dev_center_attached_network" "example" {
  name                  = "${var.dev_center_name}-dcan"

  dev_center_id         = azurerm_dev_center.this.id
  network_connection_id = azurerm_dev_center_network_connection.this.id
}
#Galería de imágenes
resource "azurerm_shared_image_gallery" "this" {
  name                = "${var.dev_center_name}sig"

  location            = azurerm_dev_center.this.location
  resource_group_name = azurerm_dev_center.this.resource_group_name

  tags = merge(var.tags, { service = "image_gallery" })
}
resource "azurerm_dev_center_gallery" "this" {
  name              = "${var.dev_center_name}cg"

  dev_center_id     = azurerm_dev_center.this.id
  shared_gallery_id = azurerm_shared_image_gallery.this.id
}
#Plantilla de instancia de VM
resource "azurerm_dev_center_dev_box_definition" "this" {
  name               = "${var.dev_center_name}dcdbd"

  location           = azurerm_dev_center.this.location
  dev_center_id      = azurerm_dev_center.this.id

  image_reference_id = var.image_reference_id
  sku_name           = var.sku_name

  tags = merge(var.tags, { service = "dev_center_dev_box_definition", type = "template" })
}
#Projecto
resource "azurerm_dev_center_project" "this" {
  name                = "${var.dev_center_name}${var.project_name}"

  resource_group_name = azurerm_dev_center.this.resource_group_name
  location            = azurerm_dev_center.this.location
  dev_center_id       = azurerm_dev_center.this.id

  tags = merge(var.tags, { service = "dev_center_project" })
}
#Entornos predefinidos
resource "azurerm_dev_center_environment_type" "dev" {
  name          = "dev-${var.dev_center_name}dcet"
  dev_center_id = azurerm_dev_center.this.id

  tags = merge(var.tags, { service = "dev_center_env_type", env = "dev" })
}
resource "azurerm_dev_center_environment_type" "testing" {
  name          = "testing-${var.dev_center_name}dcet"
  dev_center_id = azurerm_dev_center.this.id

  tags = merge(var.tags, { service = "dev_center_env_type", env = "testing" })
}
resource "azurerm_dev_center_environment_type" "prod" {
  name          = "prod-${var.dev_center_name}dcet"
  dev_center_id = azurerm_dev_center.this.id

  tags = merge(var.tags, { service = "dev_center_env_type", env = "prod" })
}
