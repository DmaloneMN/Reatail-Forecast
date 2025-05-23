resource "azurerm_application_insights" "ml" {
  name                = "${var.prefix}-${var.env}-ml-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"  # Required for ML workspace
  retention_in_days   = 90     # Customize as needed

  tags = var.tags
}
