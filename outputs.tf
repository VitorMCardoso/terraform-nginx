output "address" {
  value = module.elb-call.address
}
output "elb_public" {
  value = module.elb-call.elb_public
}

output "bucket_domain_name" {
  value = module.s3-fiap.bucket_domain_name
}

output "bucket_id" {
  value = module.s3-fiap.bucket_id
}

output "bucket_arn" {
  value = module.s3-fiap.bucket_arn
}

output "enabled" {
  value = module.s3-fiap.enabled
}

output "user_enabled" {
  value = module.s3-fiap.user_enabled
}

output "user_name" {
  value = module.s3-fiap.user_name
}

output "user_arn" {
  value = module.s3-fiap.user_arn
}

output "user_unique_id" {
  value = module.s3-fiap.user_unique_id
}

output "access_key_id" {
  value = module.s3-fiap.access_key_id
}

output "secret_access_key" {
  value = module.s3-fiap.secret_access_key
}

