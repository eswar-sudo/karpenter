resource "kubectl_manifest" "karpenter_node_pool" {

  yaml_body = <<-YAML

    apiVersion: karpenter.sh/v1

    kind: NodePool

    metadata:

      name: default

    spec:

      template:

        spec:

          requirements:

            - key: kubernetes.io/arch

              operator: In

              values: ["amd64"]

            - key: kubernetes.io/os

              operator: In

              values: ["linux"]

            - key: karpenter.sh/capacity-type

              operator: In

              values: ["on-demand"]

            - key: karpenter.k8s.aws/instance-category

              operator: In

              values: ["c", "m", "r"]

            - key: karpenter.k8s.aws/instance-generation

              operator: Gt

              values: ["2"]

          nodeClassRef:

            apiVersion: karpenter.k8s.aws/v1

            kind: EC2NodeClass

            name: default

          expireAfter: 720h

      limits:

        cpu: 1000

      disruption:

        consolidationPolicy: WhenEmptyOrUnderutilized

        consolidateAfter: 1m

  YAML

  depends_on = [kubectl_manifest.karpenter_node_class]

}


resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1
    kind: EC2NodeClass
    metadata:
      name: default
    spec:
      amiFamily: AL2023
      amiSelectorTerms:
        - id: "${var.ami_id}"
      role: "KarpenterNodeRole-${var.cluster_name}"
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${var.cluster_name}"
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${var.cluster_name}"
  YAML

  depends_on = [helm_release.karpenter]
}
