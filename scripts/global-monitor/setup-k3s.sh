mkdir -pv /opt/rancher/k3s
curl -sfL https://get.k3s.io | sh -s - --disable=traefik,servicelb                                   \
	--data-dir=/opt/rancher/k3s                              \
        --kube-apiserver-arg service-node-port-range=0-50000     \
        --bind-address=0.0.0.0              \
        --tls-san=172.31.20.79              \
        --advertise-address=172.31.20.79    \
        --node-ip=172.31.20.79              \
        --node-external-ip 35.75.12.83      \
        --cluster-cidr 10.46.0.0/16         \
        --service-cidr 10.47.0.0/16
