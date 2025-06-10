variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-main"
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "node_group_desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
  default     = 1
}

variable "eks_ami_id" {
  description = "AMI ID for the EKS nodes"
  type        = string
  default     = "ami-02457590d33d576c3" # Example for us-east-1
}

variable "instance_type" {
  description = "Instance type for the EKS nodes"
  type        = string
  default     = "t2.micro" # Example instance type
}
