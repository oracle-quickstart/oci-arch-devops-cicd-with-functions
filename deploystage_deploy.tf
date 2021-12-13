resource "oci_devops_deploy_stage" "test_deploy_stage" {
  deploy_pipeline_id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
  deploy_stage_predecessor_collection {
    items {
      id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
    }
  }
  deploy_stage_type = var.deploy_stage_deploy_stage_type


  description  = "${var.app_name}_${random_string.deploy_id.result}_deploy_with_default_image"
  display_name = "${var.app_name}_${random_string.deploy_id.result}_deploy_with_default_image"

  namespace                       = var.deploy_stage_namespace
  function_deploy_environment_id  = oci_devops_deploy_environment.test_environment.id
  docker_image_deploy_artifact_id = oci_devops_deploy_artifact.test_deploy_artifact_default.id
  defined_tags                    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_stage" "test_deploy_stage2" {
  deploy_pipeline_id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
  deploy_stage_predecessor_collection {
    items {
      id = oci_devops_deploy_pipeline.test_deploy_pipeline.id
    }
  }
  deploy_stage_type = var.deploy_stage_deploy_stage_type


  description  = "${var.app_name}_${random_string.deploy_id.result}_deploy_with_custom_image"
  display_name = "${var.app_name}_${random_string.deploy_id.result}_deploy_with_custom_image"

  namespace                       = var.deploy_stage_namespace
  function_deploy_environment_id  = oci_devops_deploy_environment.test_environment2.id
  docker_image_deploy_artifact_id = oci_devops_deploy_artifact.test_deploy_artifact_custom.id
  defined_tags                    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}