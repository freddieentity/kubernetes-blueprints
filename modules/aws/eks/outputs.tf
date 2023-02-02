output "access_cluster_command" {
  value = "To access the cluster, run 'aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.main.name}'"
}