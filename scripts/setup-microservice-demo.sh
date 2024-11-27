#git clone https://github.com/aliyun/alibabacloud-microservice-demo.git
kubectl create ns microservice-demo || true
kubectl delete secret tls otel-demo-secret -n microservice-demo || true 
kubectl create secret tls otel-demo-secret --key=/etc/ssl/onwalk.net.key  --cert=/etc/ssl/onwalk.net.pem -n microservice-demo || true
cat > microservice-demo-config.yaml << EOF
cartservice:
  name: cartservice
  image: images.onwalk.net/public/microservice-demo/cartservice:1.0.0-SNAPSHOT

productservice:
  name: productservice
  image: images.onwalk.net/public/microservice-demo/productservice:1.0.0-SNAPSHOT

nacos:
  name: nacos-standalone
  image: images.onwalk.net/public/microservice-demo/nacos-server:latest
  port: 8848
  host: nacos-standalone

frontend:
  name: frontend
  image: images.onwalk.net/public/microservice-demo/frontend:1.0.0-SNAPSHOT
  port: 8080

checkoutservice:
  name: checkoutservice
  image: images.onwalk.net/public/microservice-demo/checkoutservice:1.0.0-SNAPSHOT
EOF
helm package alibabacloud-microservice-demo/helm-chart/
helm upgrade --install microservice-demo /root/microservice-demo-0.1.0.tgz -n microservice-demo -f microservice-demo-config.yaml
