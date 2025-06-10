output "eks_cluster_id" {
  description = "The ID of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_version" {
  description = "The Kubernetes version of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.version
}

output "eks_node_group_name" {
  description = "The name of the EKS Node Group"
  value       = aws_eks_node_group.eks_node_group.node_group_name
}

output "eks_node_group_arn" {
  description = "The ARN of the EKS Node Group"
  value       = aws_eks_node_group.eks_node_group.arn
}

output "eks_node_group_status" {
  description = "The status of the EKS Node Group"
  value       = aws_eks_node_group.eks_node_group.status
}

output "eks_cluster_role_arn" {
  description = "The ARN of the IAM Role for the EKS Cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "The ARN of the IAM Role for the EKS Node Group"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_node_instance_profile_name" {
  description = "The name of the IAM Instance Profile for the EKS Node Group"
  value       = aws_iam_instance_profile.eks_node_instance_profile.name
}

output "eks_launch_template_id" {
  description = "The ID of the Launch Template for EKS Nodes"
  value       = aws_launch_template.aws_launch_template.id
}
