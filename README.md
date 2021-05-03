# hsdp-task-s3mirror

A task for use with [hsdp_function](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/function) to mirror HSDP S3 buckets.

# Usage

```hcl
module "siderite_backend" {
  source = "philips-labs/siderite-backend/cloudfoundry"

  cf_region   = "eu-west"
  cf_org_name = "hsdp-demo-org"
  cf_user     = var.cf_user
  iron_plan = "medium-encrypted"
}

resource "hsdp_function" "s3mirror" {
  name         = "s3mirror"
  docker_image = "philipslabs/hsdp-task-s3mirror:latest"
  command      = ["s3mirror.sh"]

  environment = {
    # Source bucket details
    source_access_key = "AAA"
    source_secret_key = "BBB"
    source_endpoint = "s3-eu-west-1.amazonaws.com"
    source_bucket = "cf-s3-xxx"
    source_prefix = "/data"

    # Destination bucket details
    dest_access_key = "CCC"
    dest_secret_key = "DDD"
    dest_endpoint = "s3-eu-west-1.amazonaws.com"
    dest_bucket = "cf-s3-xxx"
    dest_prefix = "/backups/data"
  }

  # Run every 6 hours
  run_every = "6h"

  # Trick to prevent concurrent runs
  timeout = 21599

  backend {
    credentials = module.siderite_backend.credentials
  }
}
```

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel

# License

License is MIT
