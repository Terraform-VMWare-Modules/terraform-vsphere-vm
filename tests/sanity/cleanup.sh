terraform destroy -var-file=private.tfvars
rm terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl
rm -rf .terraform
