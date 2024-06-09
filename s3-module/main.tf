### In this file we will specify the necessary configurations for creating an s3 bucket within xashy Inc. 
## In xashy we want that anytime a resource is created , it should tagged properly, Name , Application, environment..
## create s3 bucket 
resource "aws_s3_bucket" "mybucket" {
    count = var.bucketcount
    bucket = "${var.appname}-${var.env}-${count.index}"
    tags = {
      "Environment" = "${var.env}"
       "Appname" = "${var.appname}"
       "sensitive" = "${var.sensitive}"
       "Auditing-required" = "${var.auditing}"
    }
}


# Enable  versioning on bucket..
resource "aws_s3_bucket_versioning" "enableversining" {
  count =     var.bucketcount
  bucket = aws_s3_bucket.mybucket[count.index].id
  versioning_configuration {
    status = var.versioning
  }
}


#  make bucket public or not... "

resource "aws_s3_bucket_public_access_block" "private_bucket_block" {
  count = var.sensitive ? var.bucketcount : 0
  bucket = aws_s3_bucket.mybucket[count.index].id

  block_public_acls   = true
  block_public_policy =  var.sensitive
  ignore_public_acls  = true
  restrict_public_buckets = var.sensitive
}

# Enable Object lock 
resource "aws_s3_bucket_object_lock_configuration" "example" {
  count = var.auditing ? var.bucketcount : 0
  bucket = aws_s3_bucket.mybucket[count.index].id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 300
    }
  }
}

# Enable server access logging when any of the variables are true.

resource "aws_s3_bucket_logging" "serveraccesslogging" {
  count   = (var.sensitive  || var.auditing) ? var.bucketcount : 0
  bucket = aws_s3_bucket.mybucket[count.index].id
  target_bucket = "bucketservelogging"
  target_prefix =   "${var.appname}-${var.env}-${count.index}"
}


