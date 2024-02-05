variable "acl_host" {
  type        = string
  description = "Host from which principal listed in acl_principal will have access."
}

variable "acl_operation" {
  type        = string
  description = "Operation that is being allowed or denied. Valid values: Unknown, Any, All, Read, Write, Create, Delete, Alter, Describe, ClusterAction, DescribeConfigs, AlterConfigs, IdempotentWrite."
  validation {
    condition     = contains(["Unknown", "Any", "All", "Read", "Write", "Create", "Delete", "Alter", "Describe", "ClusterAction", "DescribeConfigs", "AlterConfigs", "IdempotentWrite"], var.acl_operation)
    error_message = "Valid values: Unknown, Any, All, Read, Write, Create, Delete, Alter, Describe, ClusterAction, DescribeConfigs, AlterConfigs, IdempotentWrite."
  }
}

variable "acl_permission_type" {
  type        = string
  description = "Type of permission. Valid values are Unknown, Any, Allow, Deny."
  validation {
    condition     = contains(["Unknown", "Any", "Allow", "Deny"], var.acl_permission_type)
    error_message = "Valid values: Unknown, Any, Allow, Deny"
  }
}

variable "acl_principal_prefix" {
  type        = string
  description = "Prefix for the ACL principal. Principal is constructed as $${var.acl_principal_prefix}$${local.offset + count.index}$${acl_principal_suffix}"
}

variable "acl_principal_suffix" {
  type        = string
  description = "Suffix for the ACL principal. Principal is constructed as $${var.acl_principal_prefix}$${local.offset + count.index}$${acl_principal_suffix}"
}

variable "acls_per_batch" {
  type = number
  validation {
    condition     = var.acls_per_batch > 0 && var.acls_per_batch <= 5000
    error_message = "0 < acls_per_batch <= 5000; Higher numbers will be super slow to generate the tf state graph. Put a `count` argument on an instantiation of this module instead."
  }
}

variable "index" {
  type        = number
  description = "The index of this module instantiation. Assumes multiple copies of this module will be created using the count argument."
  validation {
    condition     = var.index >= 0
    error_message = "Index must be >= 0."
  }
}

variable "max_acl" {
  type        = number
  description = "The id of the highest ACL to apply. ACLs will be created up to and including this id."
  validation {
    condition     = var.max_acl >= 0
    error_message = "Max ACL must be >= 0."
  }
}

variable "resource_name" {
  type        = string
  description = "The name of the resource being applied. When applying topics (the default), this is the topic name."
}

variable "resource_pattern_type_filter" {
  type        = string
  description = "The pattern filter. Valid values are Prefixed, Any, Match, Literal"
  validation {
    condition     = contains(["Prefixed", "Any", "Match", "Literal"], var.resource_pattern_type_filter)
    error_message = "Valid values: Prefixed, Any, Match, Literal."
  }
}

variable "resource_type" {
  type        = string
  description = "The type of resource. Valid values are Unknown, Any, Topic, Group, Cluster, TransactionalID"
  validation {
    condition     = contains(["Unknown", "Any", "Topic", "Group", "Cluster", "TransactionalID"], var.resource_type)
    error_message = "Valid values: Unknown, Any, Topic, Group, Cluster, TransactionalID."
  }
}
