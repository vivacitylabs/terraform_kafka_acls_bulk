# Kafka ACLs bulk - Terraform module

This module creates Kafka ACLs in bulk.

On each `terraform plan`, terraform builds a state graph of the resources in the module to be deployed.
Each node in the graph contains a copy of the state up to that node.
When applying modules containing a large (>1000) number of resources, building the graph can become very slow.

Fortunately, graphs are module-specific, i.e. a separate graph is built for each module being applied.
This module leverages that to create multiple modules and split the resources between them.
This significantly speeds up `terraform plan`s.

This also speeds up `terraform apply`s when the `-paralellism` argument is used.

It is **strongly** recommended to set `-parallelism` to the number of resources per module. This defaults to `500`.
If in doubt, set it higher.
There is very little penalty to setting `-paralellism` too high, but there can be a significant penalty if it is low.

## Usage

### Minimal configuration

The example below contains all the required variables to create a vault connection.

`source` specifies where to find the module definition. All other variables are documented [below](#full-configuration)

```terraform
module "acls" {
  source               = "github.com/vivacitylabs/terraform_kafka_acls_bulk?ref=v0.1.0"
  acl_principal_prefix = "User:prefix-"
  acl_principal_suffix = ".suffix.example.com"
  max_acl              = 10000
  resource_name        = "my_topic"
}
```

### Full Configuration

All variables are set to their default values, except for required variables which have no default value.
Variables are documented using the `description` attribute in the `variables.tf` file.

```terraform
module "acls" {
  source               = "github.com/vivacitylabs/terraform_kafka_acls_bulk?ref=v0.1.0"
  acl_principal_prefix = "User:prefix-"
  acl_principal_suffix = ".suffix.example.com"
  max_acl              = 10000
  resource_name        = "my_topic"

  acl_host                     = "*"
  acl_operation                = "Write"
  acls_per_batch               = 500
  resource_pattern_type_filter = "Literal"
  acl_permission_type          = "Allow"
  resource_type                = "Topic"
  min_acl                      = 0
}
```

[//]: # (### Advanced Configuration)
