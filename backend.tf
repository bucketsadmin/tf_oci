##########################################################################################################
## S3 backend
## https://developer.hashicorp.com/terraform/language/settings/backends/s3
##########################################################################################################
terraform {
  backend "s3" {
    bucket                      = "terraform-state" # Name of the S3 bucket
    key                         = "oci.tfstate"     # Name of the tfstate file
    endpoints                   = { s3 = "https://s3.jjsimpson.xyz" }
    region                      = "oci-us-east" # Region validation will be skipped
    skip_credentials_validation = true          # Skip AWS related checks and validations
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://www.terraform.io/language/settings/backends/s3#force_path_style
  }
}
