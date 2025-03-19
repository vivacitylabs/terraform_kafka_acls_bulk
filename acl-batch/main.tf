locals {
  offset = (var.index * var.acls_per_batch) + var.min_acl
  ids = setsubtract(toset([
    for id in range(local.offset, min(var.acls_per_batch + local.offset, var.max_acl)) : tostring(id)
  ]), toset([for id in var.excluded_ids : tostring(id)]))
}

resource "kafka_acl" "kafka_acl" {
  for_each                     = setunion(local.ids, var.explicit_ids)
  acl_permission_type          = var.acl_permission_type
  acl_principal                = "${var.acl_principal_prefix}${each.value}${var.acl_principal_suffix}"
  acl_host                     = var.acl_host
  acl_operation                = var.acl_operation
  resource_type                = var.resource_type
  resource_pattern_type_filter = var.resource_pattern_type_filter
  resource_name                = var.resource_name
}
