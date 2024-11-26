helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
kubectl create ns otel || true
kubectl delete secret tls otel-demo-secret -n otel || true 
kubectl create secret tls otel-demo-secret --key=/etc/ssl/onwalk.net.key  --cert=/etc/ssl/onwalk.net.pem -n otel || true
cat > otel-demo-config.yaml << EOF
default:
  image:
    repository: images.onwalk.net/public/opentelemetry/demo
    tag: ""
    pullPolicy: IfNotPresent
components:
  frontend:
    ingress:
      enabled: true
      ingressClassName: nginx
      hosts:
        - host: otel-demo.onwalk.net
          paths:
            - path: /
              pathType: Prefix
              port: 8080
      tls:
        - secretName: otel-demo-secret
          hosts:
            - otel-demo.onwalk.net
jaeger:
  enabled: true
opentelemetry-collector:
  enabled: true
opensearch:
  enabled: false
EOF
helm upgrade --install otel-demo open-telemetry/opentelemetry-demo -n otel -f otel-demo-config.yaml
