## How to use this repository
This repository contains only terraform module source code. It is intended to provide the building blocks for infrastructure in other projects.

### Terraform
Most efficiently, these modules can be imported directly into your terraform project using github. For example, using git over SSH to fetch the VPC module. Note the double slash (`//`)
```hcl
module "vpc" {
  source = "git@github.com:gituser/some-repo.git//src/vpc"
  /* other confguration options here */
}
```

### Terragrunt
Similarly, terragrunt supports sourcing over SSH. Note the double slash (`//`):
```hcl
terraform {
  source = "git@github.com:gituser/some-repo.git//src/vpc"
}
```

## Auto-Docs
If the program `terraform-docs` is installed, it can be used to generate a README.md inside each module directory. Invoke `scripts/doc-all.sh` to generate an updated README for each module.

Custom documentation can be added by editing `README.md_part` in the module's source directory. The script attempts to not overwrite "old" README files. 

## Auto-Formatting
If the program `terraform` is installed, it can be used to automatically format your module source code. Invoke `scripts/fmt-all.sh` to format all known .tf files in the module source directory
