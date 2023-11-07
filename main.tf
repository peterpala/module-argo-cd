provider "kubernetes" {
  load_config_file       = false
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_cert_data)
  host                   = var.kubernetes_cluster_endpoint
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", "${var.kubernetes_cluster_name}"]
  }
}

provider "helm" {
  kubernetes {
    load_config_file       = false
    cluster_ca_certificate = base64decode(var.kubernetes_cluster_cert_data)
    host                   = var.kubernetes_cluster_endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws-iam-authenticator"
      args        = ["token", "-i", "${var.kubernetes_cluster_name}"]
    }
  }
}



/*
provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "msur" {
  name = var.kubernetes_cluster_id
}

provider "kubernetes" {
  load_config_file       = false
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.msur.certificate_authority.0.data)
  host                   = data.aws_eks_cluster.msur.endpoint
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", "${data.aws_eks_cluster.msur.name}"]
  }
}



provider "helm" {
  kubernetes {
    load_config_file       = false
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.msur.certificate_authority.0.data)
    host                   = data.aws_eks_cluster.msur.endpoint
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws-iam-authenticator"
      args        = ["token", "-i", "${data.aws_eks_cluster.msur.name}"]
    }
  }
}
*/
