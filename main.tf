
module "eks_karpenter" {
  source        = "./modules"


cluster_name = "eks-security-test"
region       = "us-east-2"
karpenter_namespace = "karpenter"
account_id   = "data.aws_caller_identity.current.account_id"
subnet_ids = [
  "subnet-0d972949238d7c7d1",
  "subnet-07c37ae955221c51c"
]

sg_ids = [
  "sg-0ab553f9b55550cde",
  "sg-0630b136c0a618e25"
]
ami_id = "ami-07fa6c030f4802c74"
cpu = "1"
memory = "1Gi"
}
