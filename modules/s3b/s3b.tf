resource "aws_s3_bucket" "b" {
  bucket = var.bucket
  acl    = var.acl

}

output "out_s3b_id" {
    value = aws_s3_bucket.b.id
}