resource "oci_artifacts_container_repository" "test_container_repository" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "oci-function-python-defaultimage-${random_id.tag.hex}"
  #Optional
  is_public = var.container_repository_is_public
}

resource "oci_artifacts_container_repository" "test_container_repository2" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "oci-function-python-customimage-${random_id.tag.hex}"
  #Optional
  is_public = var.container_repository_is_public
}

resource "oci_devops_deploy_artifact" "test_deploy_artifact_default" {

  #Required
  argument_substitution_mode = var.deploy_artifact_argument_substitution_mode
  deploy_artifact_source {
    #Required
    deploy_artifact_source_type = var.deploy_artifact_deploy_artifact_source_deploy_artifact_source_type

    #Optional
    image_uri     = "${local.ocir_docker_repository}/${local.ocir_namespace}/${oci_artifacts_container_repository.test_container_repository.display_name}:$${BUILDRUN_HASH}"
    image_digest  = " "
    #image_digest  = oci_devops_build_run.test_build_run.build_outputs[0].delivered_artifacts[0].items[0].delivered_artifact_hash
    repository_id = oci_devops_repository.test_repository.id
  }

  deploy_artifact_type = var.deploy_artifact_deploy_artifact_type
  project_id           = oci_devops_project.test_project.id

  #Optional
  display_name = "${oci_artifacts_container_repository.test_container_repository.display_name}"
}

resource "oci_devops_deploy_artifact" "test_deploy_artifact_custom" {

  #Required
  argument_substitution_mode = var.deploy_artifact_argument_substitution_mode
  deploy_artifact_source {
    #Required
    deploy_artifact_source_type = var.deploy_artifact_deploy_artifact_source_deploy_artifact_source_type

    #Optional
    image_uri     = "${local.ocir_docker_repository}/${local.ocir_namespace}/${oci_artifacts_container_repository.test_container_repository2.display_name}:$${BUILDRUN_HASH}"
    image_digest  = " "
    repository_id = oci_devops_repository.test_repository.id
  }

  deploy_artifact_type = var.deploy_artifact_deploy_artifact_type
  project_id           = oci_devops_project.test_project.id

  #Optional
  display_name = "${oci_artifacts_container_repository.test_container_repository2.display_name}"
}