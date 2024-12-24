#!/bin/bash

https://github.com/containerd/nerdctl/releases/download/v2.0.2/nerdctl-2.0.2-linux-amd64.tar.gz

cat > /opt/deepflow-registry/compose.yaml << EOF
deepflow-registry:
  image: registry:2.7.1
  container_name: deepflow-registry
  restart: always
  network_mode: host
  volumes:
    - /usr/local/deepflow/registry:/var/lib/registry
    - ./config/deepflow-registry.yaml:/etc/docker/registry/config.yml
    - ./config/certs/domain.crt:/etc/docker/registry/domain.crt
    - ./config/certs/domain.key:/etc/docker/registry/domain.key
EOF

sudo nerdctl compose -f /opt/deepflow-registry/compose.yaml down
sudo nerdctl compose -f /opt/deepflow-registry/compose.yaml up -d

#运行时为Containerd
#nerdctl load -i /usr/local/deepflow/registry.tar
#nerdctl run -d -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 --net=host -v /usr/local/deepflow/registry:/var/lib/registry --restart=always --name registry hub.deepflow.yunshan.net/dev/registry:latest
