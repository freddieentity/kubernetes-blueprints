module "elasticsearch" {
  source = "../../resources/toolchain/elasticsearch"
  namespace = var.namespace
}