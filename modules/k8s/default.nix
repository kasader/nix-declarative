{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl # kubernetes-cli
    kubernetes-helm # helm
    kustomize
    k9s
    kubectx # provides kubectx + kubens
    stern
    minikube
    kubeconform
    kube-linter
    conftest
  ];
}
