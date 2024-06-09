output "bucket-id" {
  description = "should diplay the id of the bucket"
  value = aws_s3_bucket.mybucket[*].id
}

output "bucket-arn" {
  description = "should diplay the arn of the bucket"
  value = aws_s3_bucket.mybucket[*].arn
}