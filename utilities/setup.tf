resource "helm_release" "calico" {
    name             = "calico"
  repository       = "https://docs.tigera.io/calico/charts"
  chart            = "tigera-operator"
  namespace        = "calico-system"
  create_namespace = true
  version          = "v3.26.4"
}


resource "helm_release" "kubeslice-controller" {
  name = "kubeslice-controller"
  repository = "https://kubeslice.github.io/kubeslice"
  chart = "kubeslice-controller"
  namespace = "kubeslice-controller"
  create_namespace = true
  values = [file("values/controller.yaml")]
}

resource "helm_release" "istio-base" {
    name = "istio-base"
    repository = "https://kubeslice.aveshalabs.io/repository/kubeslice-helm-ent-prod/"
    chart = "istio-base"
    namespace = "istio-system"
    create_namespace = true
  
}

resource "helm_release" "istiod" {
    name = "istiod"
    repository = "https://kubeslice.aveshalabs.io/repository/kubeslice-helm-ent-prod/"
    chart = "istio-discovery"
    namespace = "istio-system"
    create_namespace = true
    depends_on = [ helm_release.istio-base ]
  
}

resource "helm_release" "kubeslice-ui" {
  name = "kubeslice-ui"
  repository = "https://kubeslice.aveshalabs.io/repository/kubeslice-helm-ent-prod/"
  chart = "kubeslice-ui"
  namespace = "kubeslice-controller"
  create_namespace = true
  values = [file("values/ui.yaml")]
}