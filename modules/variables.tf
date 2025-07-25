
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}


variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "karpenter_namespace" {
  description = "Namespace where Karpenter is deployed"
  type        = string
  default     = "karpenter"
}


variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to tag for Karpenter"
}

variable "sg_ids" {
  type        = list(string)
  description = "List of security group IDs to tag for Karpenter"
}

variable "ami_id" {
  type        = string
  description = "provide manged node ami-id"
}

variable "cpu" {
  type = string
}

variable "memory" {
  type = string
}
