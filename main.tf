# EKS Cluster and Node Group Setup
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name # "main"
  version  = var.cluster_version # "1.27"
  
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnet_ids
  }

  tags     = module.tag.tags
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = module.vpc.private_subnet_ids

  scaling_config {
    desired_size = var.node_group_desired_size # 2
    max_size     = var.node_group_max_size     # 3
    min_size     = var.node_group_min_size     # 1
  }

#   launch_template {
#     id      = aws_launch_template.aws_launch_template.id
#     version = "$Latest"
#   }

  tags = module.tag.tags
}

# Create IAM role for EKS node group
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = module.tag.tags
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = module.tag.tags
}

resource "aws_iam_instance_profile" "eks_node_instance_profile" {
  name = "${var.cluster_name}-eks-node-instance-profile"
  role = aws_iam_role.eks_node_role.name

  tags = module.tag.tags
}

# Policy Attachments for EKS Roles
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
    role       = aws_iam_role.eks_node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


# Launch Template for EKS Nodes
# This template is used to define the configuration for the EC2 instances that will run the EKS nodes.
# It includes the AMI ID, instance type, IAM instance profile, and user data script.
# The user data script is used to bootstrap the EKS nodes and configure them to join the EKS cluster.
# The user data script is expected to be in a file named "user_data.sh.tpl" in the same directory as this Terraform configuration.            

resource "aws_launch_template" "aws_launch_template" {
    name_prefix   = "${var.cluster_name}-launch-template"
    image_id      = var.eks_ami_id                      # "ami-0c55b159cbfafe1f0" for us-east-1
    instance_type = var.instance_type                   # "t2.micro"

    instance_market_options {
        market_type = "spot"
        spot_options {
            spot_instance_type = "persistent"
        }
    }

    # iam_instance_profile {
    #     name = aws_iam_instance_profile.eks_node_instance_profile.name
    # }

    # user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    #     cluster_name = var.cluster_name
    # }
    # ))

    tags = module.tag.tags
}