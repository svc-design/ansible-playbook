#!/bin/bash

wget https://github.com/containerd/nerdctl/releases/download/v2.0.2/nerdctl-full-2.0.2-linux-amd64.tar.gz

sudo mkdir -pv /etc/nerdctl
sudo touch /etc/nerdctl/nerdctl.toml

sudo cat > /etc/nerdctl/nerdctl.toml << EOF
debug          = false
debug_full     = false
address        = "unix:///run/k3s/containerd/containerd.sock"
namespace      = "k8s.io"
snapshotter    = "stargz"
cgroup_manager = "cgroupfs"
hosts_dir      = ["/etc/containerd/certs.d", "/etc/docker/certs.d"]
experimental   = true
EOF

sudo CONTAINERD_ADDRESS=/run/k3s/containerd/containerd.sock nerdctl --namespace k8s.io ps
