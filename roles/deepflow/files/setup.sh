#!/bin/bash
set -x
export domain=$1
export secret=$2
export namespace=$3

cat << EOF > values-custom.yaml
clickhouse:
  enabled: true
server:
  enabled: true
  service:
    type: ClusterIP
grafana:
  enabled: true
  service:
    type: ClusterIP
  ingress:
    enabled: true
    ingressClassName: nginx
    hosts:
      - grafana.onwalk.net
    tls:
      - secretName: obs-tls
        hosts:
          - grafana.onwalk.net
EOF
helm repo add deepflow https://deepflowio.github.io/deepflow
helm repo update deepflow # use `helm repo update` when helm < 3.7.0
#helm upgrade --install deepflow -n monitoring deepflow/deepflow --create-namespace --version 6.4.9 -f values-custom.yaml
helm upgrade --install deepflow -n monitoring deepflow/deepflow --create-namespace --version 6.2.6 -f values-custom.yaml