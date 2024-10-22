## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.4 |
| aws | > 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | > 5.0.0 |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cleanup\_package | Automatically delete package.zip after successful upload | `bool` | `true` | no |
| runtime | runtime to use for this function, such as python3.7 | `string` | n/a | yes |
| source\_key | A filename-friendly string which causes re-provisioning of the package file when changed. A git hash is a good candidate | `string` | n/a | yes |
| source\_path | Absolute path of the source files | `string` | n/a | yes |
| target\_bucket | Upload the package to this bucket. Bucket versioning is recommended | `string` | n/a | yes |
| target\_object\_path | Full Path of the destination filename in s3 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| s3\_object\_arn | ARN of the package |
| s3\_object\_bucket | Bucket where the package is stored |
| s3\_object\_key | Filename of the package in S3 |
| s3\_object\_version\_id | Version ID of the most recently built package |

# About
In short, this module takes an existing directory, builds as needed, and uploads it to S3 as a lambda-compatible package. S3 versioning is supported in the module outputs, so that consuming lambda functions may switch to newer versions as desired. Note that this module only manages a single live resource: the S3 object. This module does not manage any bucket policies.

# Packagers
A packager builds a zip file which is compatible with AWS lambda. They are named after their corresponding lambda runtime. Currently supported packagers are:
* `python3.7`
* `generic`

The `generic` packager simply invokes "build_lambda.sh" from the source directory. It is a stopgap for runtimes not yet added to the module.

More packagers can be added to the `packagers/` directory. All packagers have the following environment vars when invoked:

* `TF_PATH` : The absolute path of this module
* `RUNTIME` : The contents of `var.runtime`
* `SOURCE_PATH` : The path containing the source code to be packaged
* `PACKAGE_ZIP` : A temporary empty zip file to which files will be added

Using this information, the module can be extended to include additional languages. Packager scripts should add files to `PACKAGE_ZIP`

# Lifecycle quirks
This module attempts to de-duplicate running the provisioner script by detecting changes in the source code. This is achieved by providing a `source_key` variable to the module. This is used in two locations:

1. To notify the provisioner script that it needs to re-package our code
1. To notify terraform that the package needs to be [re]-uploaded as an S3 object

The operator is responsible for notifying the module about changes to the source code via the `source_key` variable. This module is designed around using a git commit hash, but is not restricted to any particular method.

If for some reason, the provisioner is not picking up changes to your code, you can `terraform taint 'terraform_data.package'` to force re-provisioning on the next run. This should not happen if you are updating your `source_key` in step with your code.
