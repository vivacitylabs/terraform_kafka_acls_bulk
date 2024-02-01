terraform {
  required_version = ">= 1.4.5"

  required_providers {
    kafka = {
      source  = "eh-steve/kafka"
      version = ">= 0.5.5"
    }
  }
}
