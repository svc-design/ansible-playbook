#!/bin/bash

set -e

helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create ns monitoring || true

helm upgrade --install kube-state-metrics prometheus-community/kube-state-metrics \
  --namespace monitoring --create-namespace

cat > grafana-agent-config.yaml << EOF
global:
  image:
    registry: "images.onwalk.net/public"
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
  prometheus:
    instance: default
    remoteWrite:
      - url: http://deepflow-agent.deepflow.svc.cluster.local/api/v1/prometheus 
    scrapeConfigs:
      - job_name: 'kube-state-metrics'
        static_configs:
          - targets:
              - kube-state-metrics.monitoring.svc.cluster.local:8080
        relabel_configs:
          - action: keep
            source_labels: [__meta_kubernetes_service_name]
            regex: kube-state-metrics

logs:
  enabled: false
traces:
  enabled: false
EOF

helm upgrade --install grafana-agent grafana/grafana-agent \
  --namespace monitoring \
  -f grafana-agent-config.yaml

kubectl get pods -n monitoring

