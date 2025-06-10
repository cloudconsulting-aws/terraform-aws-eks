# terraform-aws-eks

This module provides a Terraform configuration for deploying an Amazon Elastic Kubernetes Service (EKS) cluster. It supports VPC integration, node groups, IAM roles, and follows best practices for production-ready Kubernetes on AWS.

## Resources

This module deploys the following AWS resources:

1. **EKS Cluster**:
    - `aws_eks_cluster`: Creates the Amazon EKS cluster with the specified version and VPC configuration.
    - Associated IAM role (`aws_iam_role.eks_cluster_role`) with the `AmazonEKSClusterPolicy` attached.

2. **Node Group**:
    - `aws_eks_node_group`: Manages the worker nodes for the EKS cluster, including scaling configurations.
    - Associated IAM role (`aws_iam_role.eks_node_role`) with the following policies attached:
      - `AmazonEKSWorkerNodePolicy`
      - `AmazonEKS_CNI_Policy`
      - `AmazonEC2ContainerRegistryReadOnly`
    - `aws_iam_instance_profile`: Links the IAM role to the EC2 instances in the node group.

3. **Launch Template** (Optional):
    - `aws_launch_template`: Defines the configuration for EC2 instances, including AMI ID, instance type, and spot instance options.

## Variables

| Name                     | Description                              | Type   | Default                     |
|--------------------------|------------------------------------------|--------|-----------------------------|
| `cluster_name`           | Name of the EKS cluster                 | string | `eks-main`                  |
| `cluster_version`        | Version of the EKS cluster              | string | `1.27`                      |
| `node_group_desired_size`| Desired size of the EKS node group       | number | `1`                         |
| `node_group_max_size`    | Maximum size of the EKS node group       | number | `2`                         |
| `node_group_min_size`    | Minimum size of the EKS node group       | number | `1`                         |
| `eks_ami_id`             | AMI ID for the EKS nodes                | string | `ami-02457590d33d576c3`     |
| `instance_type`          | Instance type for the EKS nodes         | string | `t2.micro`                  |

## Usage

```hcl
module "eks" {
     source                  = "path/to/this/module"
     cluster_name            = "my-eks-cluster"
     cluster_version         = "1.27"
     node_group_desired_size = 2
     node_group_max_size     = 5
     node_group_min_size     = 1
     eks_ami_id              = "ami-0abcdef1234567890"
     instance_type           = "t3.medium"
}
```

## Outputs

This module can be extended to include outputs such as the cluster endpoint, node group details, and IAM roles.

## License

This project is licensed under the Apache License 2.0. See the LICENSE file for details.
