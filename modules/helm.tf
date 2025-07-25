


resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "karpenter"
  create_namespace = true

  repository       = "oci://public.ecr.aws/karpenter"
  version          = "1.5.2"

  chart = "karpenter"

  wait = true

  set = [ 
    {
    name  = "settings.clusterName"
    value = var.cluster_name
  },
  {
    name  = "logLevel"
    value = "debug"
  },
  {
    name  = "installCRDs"
    value = "true"
  },
  {
    name  = "settings.interruptionQueue"
    value = var.cluster_name
  },
  {
    name  = "serviceAccount.create"
    value = "false"
  },
  {
    name  = "serviceAccount.name"
    value = "karpenter"
  },
  {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "arn:aws:iam::307946672793:role/karpenter-poc-karpenter-node"
  },
  {
    name  = "controller.resources.requests.cpu"
    value = var.cpu
  },
 {
    name  = "controller.resources.requests.memory"
    value = var.memory
  },
 {
    name  = "controller.resources.limits.cpu"
    value = var.cpu
  },
  {
    name  = "controller.resources.limits.memory"
    value = var.memory
  }
]
}
