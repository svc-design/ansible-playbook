
# ansible-playbook

This repository contains a collection of Ansible playbooks and roles for various infrastructure setups and service management tasks.

## Playbook 角色说明

### Charts

| Role                        | Description                                           | CICD  | Validate | Last Update |
|-----------------------------|-------------------------------------------------------|-------|----------|-------------|
| `app`                        | 应用程序服务角色，提供应用程序运行所需的服务。          |       |          |             |
| `clickhouse`                 | 用于设置 ClickHouse 数据库。                          |       |          |             |
| `harbor`                     | 容器镜像仓库角色，用于存储和管理容器镜像。              |       |          |             |
| `node-exporter`              | 用于导出系统和硬件的监控数据。                        |       |          |             |
| `postgresql`                 | PostgreSQL 数据库角色，用于提供 PostgreSQL 数据库服务。|       |          |             |
| `redis`                      | Redis 数据库角色，用于提供 Redis 数据库服务。         |       |          |             |
| `chartmuseum`                | 图表仓库角色，用于存储和管理 Kubernetes 图表。          |       |          |             |
| `gitlab`                     | 代码仓库角色，用于存储和管理代码。                    |       |          |             |
| `mysql`                      | MySQL 数据库角色，用于提供 MySQL 数据库服务。          |       |          |             |
| `argo-server`                | 用于设置和管理 Argo Server。                          |       |          |             |
| `deepflow`                   | 用于流量监控与网络性能分析的 DeepFlow 服务。           |       |          |             |
| `jenkins`                    | Jenkins 自动化构建工具角色，用于 CI/CD 管道。          |       |          |             |
| `observability-agent`        | 用于管理 Observability 代理。                          |       |          |             |
| `observability-server`       | 用于设置 Observability 服务端。                       |       |          |             |
| `chaos-mesh`                 | 用于 Chaos Engineering 测试的 Chaos Mesh 角色。       |       |          |             |
| `flagger-loadtester`         | 用于负载测试的 Flagger Loadtester 角色。              |       |          |             |
| `keycloak`                   | 用于管理身份认证和授权服务。                          |       |          |             |
| `splunk-otel-collector`      | 用于配置 Splunk OpenTelemetry Collector。             |       |          |             |
| `chartmuseum`                | 用于存储和管理 Kubernetes Chart 图表仓库。            |       |          |             |
| `openldap`                   | 用于设置和管理 OpenLDAP 身份认证服务。                |       |          |             |

### Docker

| Role                 | Description                                          | CICD  | Validate | Last Update |
|----------------------|------------------------------------------------------|-------|----------|-------------|
| `keycloak`           | 用于管理身份认证和授权服务。                           |       |   yes    | 2024-11-10  |

### VHosts

| Role                 | Description                                          | CICD  | Validate | Last Update |
|----------------------|------------------------------------------------------|-------|----------|-------------|
| `alerting`           | 用于设置和管理警报系统。                            |       |          |             |
| `common`             | 通用角色，包含一些常用的功能，如日志记录、监控等。   |       |          |             |
| `k3s`                | 用于创建 Kubernetes 集群。                          |       |          |             |
| `k3s-reset`          | 用于重置 Kubernetes 集群。                          |       |          |             |
| `k3s-addon`          | 用于安装 Kubernetes 集群插件。                      |       |          |             |
| `secret-manger`      | 密钥管理角色，用于管理密钥。                         |       |          |             |
| `cert-manager`       | 证书管理角色，用于管理证书。                         |       |          |             |
| `wireguard-client`   | 用于设置 WireGuard 客户端。                          |       |          |             |
| `wireguard-gateway`  | 用于设置 WireGuard 网关。                            |       |          |             |
| `vault`              | 用于管理敏感数据和密钥。                            |       |          |             |
| `promtail-agent`     | 用于 Promtail 日志收集代理。                        |       |          |             |
| `prometheus-transfer`| 用于 Prometheus 数据传输设置。                      |       |          |             |
| `observability-agent`| 用于管理 Observability 代理。                       |       |          |             |
| `observability-server`| 用于设置 Observability 服务端。                    |       |          |             |
| `clickhouse`         | 用于设置 ClickHouse 数据库。                        |       |          |             |

## 使用示例

### Gather Network Information

```bash
ansible-playbook -i inventory gather_network_info.yml -e target_group=master


## 使用示例

### Gather Network Information

```bash
ansible-playbook -i inventory gather_network_info.yml -e target_group=master
Display network information on all nodes:

bash
复制代码
ansible -i inventory all -m script -a 'roles/network_info/tasks/files/display_network_info.sh'
Deploy Keycloak Server
bash
复制代码
ansible-playbook -i inventory/hosts/core playbooks/keycloak_server -D
Setup WireGuard Gateway
bash
复制代码
ansible-playbook -i inventory/hosts/vpn playbooks/wireguard_gateway.yaml -D
Setup Grafana Alloy
bash
复制代码
ansible-playbook -i inventory/k3s-cluster playbooks/init_grafana_alloy -D -C -l cn-k3s-server.svc.plus -e @playbooks/roles/alloy/files/loki_journal_sources_k3s_server.yml -e "ansible_become_pass='xxxx'"
all_in_one Scripts
To set up K3s:

bash
复制代码
curl -sfL https://mirrors.onwalk.net/public/k3s_setup.sh | bash -
To expose the Kubernetes API server via NGINX, refer to the guide here.

markdown
复制代码

### Changes:
- All roles under **Charts** have been added and listed.
- **Last Update** column is now available for future tracking of updates.

