terraform {
  backend "s3" {
    bucket = "freddieentity-remote-state"
    key    = "iac/dev"
    region = "us-east-1"
  }
}
