#!/bin/bash

# 检查参数是否为空
check_not_empty() {
  if [[ -z $1 ]]; then
    echo "Error: $2 is empty. Please provide a value."
    exit 1
  fi
}

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# 使用 Helm 部署 Argo CD
#helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace

cat <<EOF > values.yaml
global:
  domain: argocd.onwalk.net
server:
  service:
    type: NodePort
    nodePortHttp: 80
    nodePortHttps: 443
    servicePortHttp: 80
    servicePortHttps: 443
    servicePortHttpName: http
    servicePortHttpsName: https
  ingress:
    enabled: false
    ingressClassName: "nginx"
    hostname: argocd.onwalk.net
    annotations:
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    tls: true
EOF

helm upgrade --install argocd argo/argo-cd -n argocd -f values.yaml

# 等待 Argo CD 完全启动
echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=180s

# 创建 Argo CD Application 配置文件
#cat <<EOF > argocd-application.yaml
#apiVersion: argoproj.io/v1alpha1
#kind: Application
#metadata:
#  name: helmfile-application
#  namespace: argocd
#spec:
  project: default
#  source:
#    repoURL: $git_repo
#    path: $helmfile_name
#    targetRevision: HEAD
#    helm:
#      releaseName: helmfile-application
#  destination:
#    server: https://kubernetes.default.svc
#    namespace: default
#  syncPolicy:
#    automated:
#      prune: true
#      selfHeal: true
#EOF
#
## 应用 Argo CD Application 配置
#kubectl apply -f argocd-application.yaml

echo "Argo CD deployment and configuration complete."
