## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# 

resource "oci_identity_dynamic_group" "devops_pipln_dg" {
  count          = var.create_dynamic_group_for_devops_pipln_in_compartment ? 1 : 0
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  name           = "${var.app_name}-devops-pipln-dg-${random_string.deploy_id.result}"
  description    = "${var.app_name} DevOps Pipeline Dynamic Group"
  matching_rule  = "All {resource.type = 'devopsdeploypipeline', resource.compartment.id = '${var.compartment_ocid}'}"
}

resource "oci_identity_policy" "devops_compartment_policies" {
  count       = var.create_compartment_policies ? 1 : 0
  depends_on  = [oci_identity_dynamic_group.devops_pipln_dg]
  provider    = oci.home_region
  name        = "${var.app_name}-devops-compartment-policies-${random_string.deploy_id.result}"
  description = "${var.app_name} DevOps Compartment Policies"
  #  compartment_id = var.compartment_ocid
  compartment_id = var.tenancy_ocid
  statements     = local.devops_compartment_statements
}

locals {
  devops_pipln_dg = var.create_dynamic_group_for_devops_pipln_in_compartment ? oci_identity_dynamic_group.devops_pipln_dg.0.name : "void"
  allow_devops_manage_compartment_statements = [
    #    "Allow dynamic-group ${local.devops_pipln_dg} to manage all-resources in compartment id ${var.compartment_ocid}",
    "Allow dynamic-group ${local.devops_pipln_dg} to manage all-resources in tenancy",
  ]
}


resource "oci_identity_dynamic_group" "devops_coderepo_dg" {
  provider       = oci.home_region
  name           = "CodeReposDynamicGroup-${random_id.tag.hex}"
  description    = "DevOps code repository dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'devopsrepository'}"
}


resource "oci_identity_dynamic_group" "devops_build_dg" {
  provider       = oci.home_region
  name           = "MyDynamicGroup-${random_id.tag.hex}"
  description    = "DevOps repository build pipeline dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'devopsbuildpipeline'}"
}



resource "oci_identity_policy" "devopsrootpolicy" {
  provider       = oci.home_region
  name           = "devops-root-policies-${random_id.tag.hex}"
  description    = "policy created for root compartment"
  compartment_id = var.tenancy_ocid

  statements = [
    "Allow dynamic-group ${oci_identity_dynamic_group.devops_coderepo_dg.name} to manage all-resources in tenancy",
    "Allow dynamic-group ${oci_identity_dynamic_group.devops_build_dg.name} to manage all-resources in tenancy",
  ]
}

