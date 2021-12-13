## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_logging_log_group" "test_log_group" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.app_name}_${random_string.deploy_id.result}_log_group"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_logging_log" "test_log" {
  display_name = "${var.app_name}_${random_string.deploy_id.result}_devopsLog"
  log_group_id = oci_logging_log_group.test_log_group.id
  log_type     = "SERVICE"

  configuration {
    source {
      category    = "all"
      resource    = oci_devops_project.test_project.id
      service     = "devops"
      source_type = "OCISERVICE"
    }
    compartment_id = var.compartment_ocid
  }

  is_enabled         = true
  retention_duration = var.project_logging_config_retention_period_in_days
  defined_tags       = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_logging_log" "test_log1" {
    defined_tags       = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release}
    display_name       = "${var.app_name}_${random_string.deploy_id.result}_fnInvokeLog"
    freeform_tags      = {}
    log_group_id       = oci_logging_log_group.test_log_group.id
    log_type           = "SERVICE"
    retention_duration = var.project_logging_config_retention_period_in_days
    
    configuration {
        compartment_id = var.compartment_ocid

        source {
            category    = "invoke"
            resource    = oci_functions_application.test_fn_app.id
            service     = "functions"
            source_type = "OCISERVICE"
        }
    }

    timeouts {}
}



resource "oci_ons_notification_topic" "test_notification_topic" {
  compartment_id = var.compartment_ocid
  name           = "${var.app_name}_${random_string.deploy_id.result}_topic"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_project" "test_project" {
  compartment_id = var.compartment_ocid
  name           = "${var.app_name}_${random_string.deploy_id.result}_devops_project"
  notification_config {
    topic_id = oci_ons_notification_topic.test_notification_topic.id
  }
  description  = "${var.app_name}_${random_string.deploy_id.result}_devops_project"
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


