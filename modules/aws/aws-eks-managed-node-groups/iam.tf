resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "eks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" 
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach_policy_to_role" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = data.aws_iam_policy.eks_cluster_policy.arn
}
data "aws_subnet_ids" "cluster_subnet_ids" {
  vpc_id = aws_vpc.cluster_vpc.id
  depends_on = [ aws_subnet.cluster_subnet ]
}

resource "aws_iam_role" "eks_cluster_worker_role" {
  name = "eks_cluster_worker_role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach_policy_to_worker_role" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ])

  role       = aws_iam_role.eks_cluster_worker_role.name
  policy_arn = each.value
}