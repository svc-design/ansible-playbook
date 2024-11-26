helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update
kubectl create ns otel || true
helm upgrade --install otel-demo open-telemetry/opentelemetry-demo -n otel

