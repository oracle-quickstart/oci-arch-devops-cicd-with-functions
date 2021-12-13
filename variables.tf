## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

variable "app_name" {
  default     = "oci-function-cicd"
  description = "Application name. Will be used as prefix to identify resources, such as Function, VCN, DevOps, and others"
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.11"
}

variable "execute_deployment" {
  #  default = false
  default = true
}

variable "app_version" {
  default = "0.0.1"
}

variable "app_version2" {
  default = "0.0.2"
}

# ORM Schema visual control variables
variable "show_advanced" {
  default = false
}


variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "fnsubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "ocir_repo_name" {
  default = "functions"
}

variable "oci_user_name" {
  sensitive = true
  default   = ""
}

variable "oci_user_authtoken" {
  sensitive = true
  default   = ""
}

# OCIR repo name & namespace

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.oci_regions.regions[0], "key")), ".ocir.io"])
  ocir_namespace         = lookup(data.oci_objectstorage_namespace.os_namespace, "namespace")
}

## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create Dynamic Group and Policies
variable "create_dynamic_group_for_nodes_in_compartment" {
  default = true
}
variable "existent_dynamic_group_for_nodes_in_compartment" {
  default = ""
}
variable "create_compartment_policies" {
  default = true
}
variable "create_tenancy_policies" {
  default = true
}


variable "project_description" {
  default = "DevOps Project for Function deployment"
}
variable "environment_type" {
  default = "FUNCTION"
}

variable "project_logging_config_display_name_prefix" {
  default = "fn-"
}

variable "project_logging_config_is_archiving_enabled" {
  default = false
}

variable "project_logging_config_retention_period_in_days" {
  default = 30
}


variable "deploy_artifact_source_type" {
  default = "OCIR"
}

variable "deploy_artifact_type" {
  default = "DOCKER_IMAGE"
}

variable "argument_substitution_mode" {
  default = "NONE"
}

variable "create_dynamic_group_for_devops_pipln_in_compartment" {
  default = true
}

variable "deploy_stage_deploy_stage_type" {
  default = "DEPLOY_FUNCTION"
}

variable "deploy_stage_namespace" {
  default = "default"
}


variable "repository_name" {
  default ="python-function-helloworld"
}

variable "repository_default_branch" {
  default = "main"
}

variable "repository_description" {
  default = "Sample code for oci function with python "
}

variable "git_repo" {
  default = "https://github.com/RahulMR42/oci-sample-function-with-python"
}

variable "git_repo_name" {
  default = "oci-sample-function-with-python"
}

variable "repository_repository_type" {
  default = "HOSTED"
}

variable "build_pipeline_description" {
  default = "build pipeline for OCI function with Python"
}

variable "build_pipeline_build_stage_description" {
  default = "build stage for OCI function with python"
}

variable "build_pipeline_display_name" {
  default = "Function-Python-Buildpipeline"
}

variable "build_pipeline_stage_display_name" {
  default = "function-python-build"
}

variable "build_pipeline_stage_build_spec_file" {
  default = ""
} 

variable "build_pipeline_stage_build_pipeline_stage_predecessor_collection_items_id" {
  default = "id"
}

variable "build_pipeline_stage_build_pipeline_stage_type" {
  default = "BUILD"
}
variable "build_pipeline_stage_image" {
  default = "OL7_X86_64_STANDARD_10"
}

variable "build_pipeline_stage_wait_criteria_wait_duration" {
  default = "waitDuration"
}

variable "build_pipeline_stage_wait_criteria_wait_type" {
  default = "ABSOLUTE_WAIT"
}

variable "build_pipeline_stage_stage_execution_timeout_in_seconds" {
  default = 36000
}

variable "build_pipeline_stage_build_source_collection_items_branch" {
  default = "main"
}

variable "build_pipeline_stage_build_source_collection_items_connection_type" {
  default = "DEVOPS_CODE_REPOSITORY"
}

variable "build_pipeline_stage_build_source_collection_items_name" {
  default = "oci-sample-function-with-python"
}
variable "build_pipeline_stage_deliver_artifact_stage_type" {
  default = "DELIVER_ARTIFACT"
}

variable "build_pipeline_stage_deliver_artifact_collection_items_artifact_name_default" {
  default = "output_fn_default_image"
}

variable "build_pipeline_stage_deliver_artifact_collection_items_artifact_name_custom" {
  default = "output_fn_custom_image"
}

variable "deliver_artifact_stage_display_name" {
  default = "deliver-artifact"
}

variable "container_repository_is_public" {
  default = true
}
variable "deploy_artifact_argument_substitution_mode" {
  default = "SUBSTITUTE_PLACEHOLDERS"
}
variable "deploy_artifact_deploy_artifact_source_deploy_artifact_source_type" {
  default = "OCIR"
}
variable "deploy_artifact_deploy_artifact_type" {
  default = "DOCKER_IMAGE"
}
variable "deploy_pipeline_deploy_pipeline_parameters_items_name" {
  default = "BUILDRUN_HASH"
}
variable "deploy_pipeline_deploy_pipeline_parameters_items_default_value" {
  default = "example"
}
variable "deploy_pipeline_deploy_pipeline_parameters_items_description" {
  default = "Tag for docker image "
}
variable "deploy_pipeline_description" {
  default = "Devops CI/CD Pipleline demo for functions"
}

variable "build_pipeline_stage_deploy_stage_type" {
  default = "TRIGGER_DEPLOYMENT_PIPELINE"
}

variable "deploy_stage_display_name" {
  default = "Invoke-Deployment"
}
variable "build_pipeline_stage_is_pass_all_parameters_enabled" {
  default = true
}

variable "trigger_actions_type"{
  default = "TRIGGER_BUILD_PIPELINE"
}

variable "trigger_state"{
  default="ACTIVE"
}
variable "trigger_trigger_source"{
  default="DEVOPS_CODE_REPOSITORY"
}
variable "trigger_trigger_input_event_type"{
  default="PUSH"
}

variable "trigger_source_repo_branch"{
  default = "main"
}

variable "trigger_action_to_invoke"{
  default="TRIGGER_BUILD_PIPELINE"
}