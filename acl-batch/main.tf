locals {
  offset = var.index * var.acl_count
}

resource "kafka_acl" "kafka_acl" {
  count                        = min(var.acl_count, var.max_acl - local.offset)
  acl_permission_type          = var.acl_permission_type
  acl_principal                = "${var.acl_principal_prefix}${local.offset + count.index}${var.acl_principal_suffix}"
  acl_host                     = var.acl_host
  acl_operation                = var.acl_operation
  resource_type                = var.resource_type
  resource_pattern_type_filter = var.resource_pattern_type_filter
  resource_name                = var.resource_name
}
