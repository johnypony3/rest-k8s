output "endpoint" {
  value = aws_eks_cluster.rest-k8s.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.rest-k8s.certificate_authority.0.data
}
