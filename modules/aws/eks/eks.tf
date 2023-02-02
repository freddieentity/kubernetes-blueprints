resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_east_1a.id,
      aws_subnet.private_us_east_1b.id,
      aws_subnet.public_us_east_1a.id,
      aws_subnet.public_us_east_1b.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_role,
  ]
}

# ON DEMAND NG
resource "aws_eks_node_group" "on_demand" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "on_demand"
  node_role_arn   = aws_iam_role.eks_cluster_worker.arn
  instance_types = var.on_demand_instance_types
  subnet_ids = [
    aws_subnet.private_us_east_1a.id,
    aws_subnet.private_us_east_1b.id
  ]

  labels = {
    type_of_nodegroup = "on_demand_untainted"
  }

  scaling_config {
    desired_size = var.on_demand_desired_size
    max_size     = var.on_demand_max_size
    min_size     = var.on_demand_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_worker_role
  ]
}

# SPOT NG

resource "aws_eks_node_group" "spot" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "spot"
  node_role_arn   = aws_iam_role.eks_cluster_worker.arn
  instance_types = var.spot_instance_types
  subnet_ids = [
    aws_subnet.private_us_east_1a.id,
    aws_subnet.private_us_east_1b.id
  ]
  capacity_type   = "SPOT"

  labels = {
    type_of_nodegroup = "spot_untainted"
  }

  scaling_config {
    desired_size = var.spot_desired_size
    max_size     = var.spot_max_size
    min_size     = var.spot_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_worker_role
  ]
}

# ##### TAINTED WORKER NODE SETUP ##### https://www.linkedin.com/pulse/eks-cluster-using-terraform-shishir-khandelwal/

# resource "aws_launch_template" "eks_cluster_tainted_worker_node_launch_config" {
#   name = "eks_cluster_tainted_worker_node_launch_config"
#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size = 20
#       delete_on_termination = true
#       volume_type = "gp2"
#     }
#   }
#   network_interfaces {
#     security_groups = [aws_eks_cluster.main.vpc_config[0].cluster_security_group_id]
#   }
#   user_data = base64encode(<<-EOF
# MIME-Version: 1.0
# Content-Type: multipart/mixed; boundary="==7561478f-5b81-4e9d-9db6-aec8f463d2ab=="

# --==7561478f-5b81-4e9d-9db6-aec8f463d2ab==
# Content-Type: text/x-shellscript; charset="us-ascii"

# #!/bin/bash
# sed -i '/^KUBELET_EXTRA_ARGS=/a KUBELET_EXTRA_ARGS+=" --register-with-taints=some_taint1=shishir:NoSchedule,some_taint2=true:NoSchedule"' /etc/eks/bootstrap.sh

# --==7561478f-5b81-4e9d-9db6-aec8f463d2ab==--\
#   EOF
#   )
# }
# ##### TAINTED WORKER NODE CREATION  #####

# resource "aws_eks_node_group" "on_demand_tainted" {
#   cluster_name    = aws_eks_cluster.main.name
#   node_group_name = "on_demand_tainted"
#   node_role_arn   = aws_iam_role.eks_cluster_worker.arn
#   subnet_ids      = data.aws_subnet_ids.cluster_subnet_ids.ids

#   launch_template {
#    name = aws_launch_template.eks_cluster_tainted_worker_node_launch_config.name
#    version = aws_launch_template.eks_cluster_tainted_worker_node_launch_config.latest_version
#   }

#   labels = {
#     type_of_nodegroup = "on_demand_tainted"
#   }
#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   depends_on = [
#     aws_launch_template.eks_cluster_tainted_worker_node_launch_config 
#   ]
# }

