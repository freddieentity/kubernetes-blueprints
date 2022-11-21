variable "region" {
  default = "ap-southeast-1"
}

variable "az_span" {
  default = 2
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "tenant" {
  default = ""
}

variable "project" {
  default = ""
}

variable "application" {
  default = ""
}

variable "availability_zone" {
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}