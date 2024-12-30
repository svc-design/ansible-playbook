#!/bin/bash
# 脚本名称: clean-failed-pods.sh
# 作用: 删除 deepflow 命名空间中非 Running 状态的 Pod

NAMESPACE="deepflow"
echo "正在删除 $NAMESPACE 命名空间中非 Running 状态的 Pod..."
kubectl get pods -n $NAMESPACE | grep -v Running | awk 'NR>1 {print $1}' | xargs kubectl delete pod -n $NAMESPACE --force
echo "清理完成！"

NAMESPACE="openebs"
echo "正在删除 $NAMESPACE 命名空间中非 Running 状态的 Pod..."
kubectl get pods -n $NAMESPACE | grep -v Running | awk 'NR>1 {print $1}' | xargs kubectl delete pod -n $NAMESPACE --force
echo "清理完成！"

NAMESPACE="kube-system"
echo "正在删除 $NAMESPACE 命名空间中非 Running 状态的 Pod..."
kubectl get pods -n $NAMESPACE | grep -v Running | awk 'NR>1 {print $1}' | xargs kubectl delete pod -n $NAMESPACE --force
echo "清理完成！"
