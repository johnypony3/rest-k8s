resource "aws_eks_cluster" "rest-k8s" {
  name     = local.workspace_name
  role_arn = aws_iam_role.rest-k8s.arn

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.rest-k8s : subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.rest-k8s-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.rest-k8s-AmazonEKSServicePolicy,
  ]
}

resource "aws_eks_node_group" "rest-k8s" {
  cluster_name    = aws_eks_cluster.rest-k8s.name
  node_group_name = local.workspace_name
  node_role_arn   = aws_iam_role.rest-k8s-node.arn
  subnet_ids      = [for subnet in aws_subnet.rest-k8s : subnet.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.rest-k8s-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.rest-k8s-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.rest-k8s-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
