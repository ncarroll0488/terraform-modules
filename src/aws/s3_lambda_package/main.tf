resource "terraform_data" "package" {
  triggers_replace = [
    var.source_key
  ]

  input = var.source_key

  provisioner "local-exec" {
    command = "./pack.sh"
    environment = {
      RUNTIME     = var.runtime,
      SOURCE_PATH = var.source_path,
      TF_PATH     = abspath(path.module)
    }
  }
}

resource "aws_s3_object" "package" {
  depends_on = [terraform_data.package]
  bucket     = var.target_bucket

  /* Trim the trailing and starting slashes, for consistency */
  key = trim(var.target_object_path, "/")

  /*
     The packager is hard-coded to create "package.zip" in the module root.
     Normally, package.zip wouldn't exist if the package wasn't built this run.
     This is desired behavior, as we don't want to waste resources packaging up
     code that we've already built somewhere, somehow.

     What's great about the s3_object resource is it doesn't appear to open
     this file (or even validate if it exists) unless it thinks it needs to
     transmit the contents. If a change occurs to source_key, a package will
     have been created by the packager script already.
  */
  source = "package.zip"

  // When this changes, terraform will replace the contents of the S3 object
  source_hash = var.source_key
}

resource "terraform_data" "cleanup" {
  for_each   = toset(var.cleanup_package ? ["main"] : [])
  depends_on = [aws_s3_object.package]
  triggers_replace = [
    var.source_key
  ]
  provisioner "local-exec" {
    command = "rm -f package.zip"
  }
}

