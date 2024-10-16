variable "runtime" {
  type        = string
  description = "runtime to use for this function, such as python3.7"
}

variable "source_path" {
  type        = string
  description = "Absolute path of the source files"
}

variable "source_key" {
  type        = string
  description = "A filename-friendly string which causes re-provisioning of the package file when changed. A git hash is a good candidate"
}

variable "target_bucket" {
  type        = string
  description = "Upload the package to this bucket. Bucket versioning is recommended"
}

variable "target_object_path" {
  type        = string
  description = "Full Path of the destination filename in s3"
}
