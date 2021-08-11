output "access_key"{
        value=google_storage_hmac_key.terraform_key.access_id
        sensitive = true
}

output "secret_key" {
    value=google_storage_hmac_key.terraform_key.secret
    sensitive = true
  
}
output "bucket_name" {
    value=google_storage_bucket.logiq-test-poc.name
}

output "logiq_endpoint" {
  value=google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
