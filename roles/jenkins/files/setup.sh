#!/bin/bash
set -x
export domain=$1
export secret=$2
export namespace=$3
export mysql_db_password=$4

cat > values.yaml << EOF

controller:
  admin:
    username: 'admin'
    password: "jenkins"
  jenkinsUrlProtocol: "https"
  jenkinsHome: "/var/jenkins_home"
  jenkinsUrl: https://jenkins.$domain
  ingress:
    enabled: true
    annotations:
      kubernetes.io/tls-acme: "false"
    ingressClassName: nginx
    hostName: jenkins.$domain
    path: '/'
    tls:
      - secretName: $secret
        hosts:
          - jenkins.$domain
  installLatestPlugins: true
  installPlugins:
    - git:5.2.0
    - database-mysql:1.4
    - github:1.34.0
    - gitlab-plugin:1.7.16
    - pipeline-stage-view:2.33
    - database:191.vd5981b_97a_5fa_
    - locale:314.v22ce953dfe9e
    - kubernetes:4029.v5712230ccb_f8
    - workflow-job:1385.vb_58b_86ea_fff1  # Updated to resolve dependency conflicts
    - workflow-aggregator:596.v8c21c963d92d
    - credentials-binding:642.v737c34dea_6c2  # Updated to resolve dependency conflicts
    - configuration-as-code:1775.v810dc950b_514  # Updated to resolve dependency conflicts
    - docker-workflow:1.26
    - workflow-cps:3769.v8b_e595e4d40d  # Updated to resolve dependency conflicts
  JCasC:
    enabled: true
    defaultConfig: true
    configScripts:
      database: |
        unclassified:
          globalDatabaseConfiguration:
            database:
              mysql:
                hostname: mysql.database.svc.cluster.local
                port: '3306'
                username: "root"
                database: "jenkins"
                password: $mysql_db_password
                properties: "?useSSL=false"
                validationQuery: "SELECT 1"
agent:
  enabled: true
  replicas: 3
  numExecutors: 1
  jenkinsUrl: https://jenkins.$domain

persistence:
  enabled: true
  storageClass: "local-path"
  size: "10Gi"
networkPolicy:
  enabled: false
additionalConfig: {}
EOF

helm repo add jenkins https://charts.jenkins.io
helm repo update
helm upgrade --install jenkins jenkins/jenkins -n $namespace --create-namespace -f values.yaml
