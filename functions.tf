## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


resource "oci_functions_application" "test_fn_app" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.app_name}App"
  subnet_ids     = [oci_core_subnet.fnsubnet.id]
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_functions_function" "test_fn" {
  depends_on     = [oci_devops_build_pipeline_stage.test_deliver_artifact_stage]
  application_id = oci_functions_application.test_fn_app.id
  display_name   = "${var.app_name}-defaultImage"
   image = "${local.ocir_docker_repository}/${local.ocir_namespace}/${oci_artifacts_container_repository.test_container_repository.display_name}:${local.image_tag}"
  memory_in_mbs  = "256"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_functions_function" "test_fn2" {
  depends_on     = [oci_devops_build_pipeline_stage.test_deliver_artifact_stage2]
  application_id = oci_functions_application.test_fn_app.id
  display_name   = "${var.app_name}-customImage"
   image = "${local.ocir_docker_repository}/${local.ocir_namespace}/${oci_artifacts_container_repository.test_container_repository2.display_name}:${local.image_tag}"
  memory_in_mbs  = "256"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


locals{
  image_tag = oci_devops_build_run.test_build_run_1.build_outputs[0].exported_variables[0].items[0].value
}