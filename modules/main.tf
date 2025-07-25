
provider "aws" {
 region = var.region
}

provider "kubernetes" {
 host                   = data.aws_eks_cluster.cluster.endpoint
 cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
 token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
 kubernetes = {
   host                   = data.aws_eks_cluster.cluster.endpoint
   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
 }
}

data "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "aws_caller_identity" "current" {
}
