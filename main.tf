locals {
  number_of_batches = ceil((var.max_acl - var.min_acl) / var.acls_per_batch)
}

module "acl_batch" {
  count                        = local.number_of_batches
  source                       = "./acl-batch"
  acls_per_batch               = var.acls_per_batch
  index                        = count.index
  max_acl                      = var.max_acl
  min_acl                      = var.min_acl
  resource_name                = var.resource_name
  acl_operation                = var.acl_operation
  acl_principal_prefix         = var.acl_principal_prefix
  acl_principal_suffix         = var.acl_principal_suffix
  acl_host                     = var.acl_host
  acl_permission_type          = var.acl_permission_type
  resource_pattern_type_filter = var.resource_pattern_type_filter
  resource_type                = var.resource_type
  excluded_ids                 = var.excluded_ids
}

resource "kafka_acl" "kafka_acl" {
  for_each                     = toset([for id in var.explicit_ids : tostring(id)])
  acl_permission_type          = var.acl_permission_type
  acl_principal                = "${var.acl_principal_prefix}${each.value}${var.acl_principal_suffix}"
  acl_host                     = var.acl_host
  acl_operation                = var.acl_operation
  resource_type                = var.resource_type
  resource_pattern_type_filter = var.resource_pattern_type_filter
  resource_name                = var.resource_name
}
