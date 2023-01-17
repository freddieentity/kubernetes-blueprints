output "access_cluster" {
  value = "To access the cluster, run 'aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.cluster.name}'" 
}

output "aws_subnet_ids_output" {
  value = data.aws_subnet_ids.cluster_subnet_ids.ids
}