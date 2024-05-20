#!/bin/bash

# 检查参数是否为空
check_not_empty() {
  if [[ -z $1 ]]; then
    echo "Error: $2 is empty. Please provide a value."
    exit 1
  fi
}

# 检查参数是否为空
check_not_empty "$1" "DOMAIN" && DOMAIN=$1

cat > vaules.yaml << EOF
server:
  ingress:
    enabled: true
    ingressClassName: "nginx"
    hosts:
      - host: vault.$DOMAIN
        paths:
          - /
    tls:
      - secretName: vault-tls
        hosts:
          - vault.$DOMAIN
EOF

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo up
kubectl create ns vault || echo true
helm upgrade --install vault-server hashicorp/vault -n vault --create-namespace -f vaules.yaml
