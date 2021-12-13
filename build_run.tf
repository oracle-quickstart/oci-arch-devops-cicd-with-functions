## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_build_run" "test_build_run_1" {

  depends_on = [oci_devops_build_pipeline_stage.test_build_pipeline_stage,
    oci_devops_build_pipeline_stage.test_deliver_artifact_stage,
    oci_devops_build_pipeline_stage.test_deliver_artifact_stage2
    ]
    # oci_devops_build_pipeline_stage.test_deploy_stage
    #oci_devops_deploy_stage.test_deploy_stage
 

  #Required
  build_pipeline_id = oci_devops_build_pipeline.test_build_pipeline.id

  #Optional
  display_name = "build_run_${random_id.tag.hex}"
}

