resource "helm_release" "calico" {
    name             = "calico"
  repository       = "https://docs.tigera.io/calico/charts"
  chart            = "tigera-operator"
  namespace        = "calico-system"
  create_namespace = true
  version          = "v3.26.4"
}


resource "helm_release" "istio-base" {
    name = "istio-base"
    repository = "https://kubeslice.github.io/kubeslice/"
    chart = "istio-base"
    namespace = "istio-system"
    create_namespace = true
  
}

resource "helm_release" "istiod" {
    name = "istiod"
    repository = "https://kubeslice.github.io/kubeslice/"
    chart = "istio-discovery"
    namespace = "istio-system"
    create_namespace = true
    depends_on = [ helm_release.istio-base ]  
}

resource "helm_release" "kubeslice-worker" {
  name = "kubeslice-worker"
  repository = "https://kubeslice.github.io/kubeslice/"
  chart = "kubeslice-worker"
  namespace = "kubeslice-system"
  create_namespace = true
  values = [file("values/w1.yaml")]
}
