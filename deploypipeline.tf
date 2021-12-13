resource "oci_devops_deploy_pipeline" "test_deploy_pipeline" {
  #Required
  project_id   = oci_devops_project.test_project.id
  description  = var.deploy_pipeline_description
  display_name = "function_python_pipeline_${random_id.tag.hex}"

  deploy_pipeline_parameters {
    items {
      name          = var.deploy_pipeline_deploy_pipeline_parameters_items_name
      default_value = var.deploy_pipeline_deploy_pipeline_parameters_items_default_value
      description   = var.deploy_pipeline_deploy_pipeline_parameters_items_description
    }
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_environment" "test_environment" {
  display_name            = "${var.app_name}_${random_string.deploy_id.result}_devops_environment-defaultImage"
  description             = "${var.app_name}_${random_string.deploy_id.result}_devops_environment-defaultImage"
  deploy_environment_type = "FUNCTION"
  project_id              = oci_devops_project.test_project.id
  function_id             = oci_functions_function.test_fn.id
  defined_tags            = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_environment" "test_environment2" {
  display_name            = "${var.app_name}_${random_string.deploy_id.result}_devops_environment-customImage"
  description             = "${var.app_name}_${random_string.deploy_id.result}_devops_environment-customImage"
  deploy_environment_type = "FUNCTION"
  project_id              = oci_devops_project.test_project.id
  function_id             = oci_functions_function.test_fn2.id
  defined_tags            = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

