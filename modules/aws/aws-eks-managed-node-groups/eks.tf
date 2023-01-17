resource "aws_eks_cluster" "cluster" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.cluster_subnet_ids.ids
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_role,
    aws_subnet.cluster_subnet
  ]
}

resource "aws_eks_node_group" "eks_cluster_nodegroup_ondemand" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks_cluster_nodegroup_ondemand"
  node_role_arn   = aws_iam_role.eks_cluster_worker_role.arn
  subnet_ids      = data.aws_subnet_ids.cluster_subnet_ids.ids
  
  labels = {
    type_of_nodegroup = "on_demand_untainted"
  }
 
  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_worker_role
  ]
}

/*
##### SPOT WORKER NODE CREATION #####

resource "aws_eks_node_group" "eks_cluster_nodegroup_spot" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks_cluster_nodegroup_spot"
  node_role_arn   = aws_iam_role.eks_cluster_worker_role.arn
  subnet_ids      = data.aws_subnet_ids.cluster_subnet_ids.ids
  capacity_type = "SPOT"
  
  labels = {
    type_of_nodegroup = "spot_untainted"
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach_policy_to_worker_role
  ]
}

##### TAINTED WORKER NODE SETUP #####

resource "aws_launch_template" "eks_cluster_tainted_worker_node_launch_config" {
  name = "eks_cluster_tainted_worker_node_launch_config"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "gp2"
    }
  }
  network_interfaces {
    security_groups = [aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id]
  }
  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==7561478f-5b81-4e9d-9db6-aec8f463d2ab=="

--==7561478f-5b81-4e9d-9db6-aec8f463d2ab==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
sed -i '/^KUBELET_EXTRA_ARGS=/a KUBELET_EXTRA_ARGS+=" --register-with-taints=some_taint1=shishir:NoSchedule,some_taint2=true:NoSchedule"' /etc/eks/bootstrap.sh

--==7561478f-5b81-4e9d-9db6-aec8f463d2ab==--\
  EOF
  )
}
##### TAINTED WORKER NODE CREATION  #####

resource "aws_eks_node_group" "eks_cluster_nodegroup_ondemand_tainted" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "eks_cluster_nodegroup_ondemand_tainted"
  node_role_arn   = aws_iam_role.eks_cluster_worker_role.arn
  subnet_ids      = data.aws_subnet_ids.cluster_subnet_ids.ids
  
  launch_template {
   name = aws_launch_template.eks_cluster_tainted_worker_node_launch_config.name
   version = aws_launch_template.eks_cluster_tainted_worker_node_launch_config.latest_version
  }

  labels = {
    type_of_nodegroup = "on_demand_tainted"
  }
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_launch_template.eks_cluster_tainted_worker_node_launch_config 
  ]
}
*/

