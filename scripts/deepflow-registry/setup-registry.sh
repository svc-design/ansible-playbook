#!/bin/bash

#https://github.com/containerd/nerdctl/releases/download/v2.0.2/nerdctl-2.0.2-linux-amd64.tar.gz
sudo mkdir -pv /opt/deepflow-registry/config/
sudo cp compose.yaml /opt/deepflow-registry/config/compose.yaml
sudo cp deepflow-registry.yaml /opt/deepflow-registry/config/deepflow-registry.yaml
#运行时为Containerd
sudo CONTAINERD_ADDRESS=/run/k3s/containerd/containerd.sock nerdctl --namespace k8s.io load -i /usr/local/deepflow/registry.tar
sudo CONTAINERD_ADDRESS=/run/k3s/containerd/containerd.sock nerdctl --namespace k8s.io compose -f /opt/deepflow-registry/config/compose.yaml down
sudo CONTAINERD_ADDRESS=/run/k3s/containerd/containerd.sock nerdctl --namespace k8s.io compose -f /opt/deepflow-registry/config/compose.yaml up -d
