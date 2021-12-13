# oci-arch-devops

--------
⚡ Its not baked fully yet ...

To do (In next two weeks!)

- OCI RMS integration .
- Lots of tests 😉 .
- Some renaming.
- Ofcourse a read me.

To test ,

- build a terraform.tfvars as below 

```
# Authentication
tenancy_ocid         = "ocid1.tenancy.oc1..xxxxxx"
user_ocid            = "ocid1.user.oc1..xxxxxx"
fingerprint          = "6e:69:bb:b5:22xxxx"
private_key_path     = "<Path to PEM File>"

# Region
region = "us-ashburn-1"

# Compartment
compartment_ocid = "ocid1.compartment.oc1..xxxxx"

# OCI  
oci_user_name         = "xxxx/yyy"
oci_user_authtoken     = "zzzzz"

# Set to TRUE if you want to automatically start DevOps Pipeline Deployment.
update_function_with_new_image = true # We will remove this in the next version.

```

- Play 

```
$terraform init
$terraform plan -out plan.out
$terraform apply plan.out
```
- Kill it 

```
$terraform destroy
```