#!/bin/bash
set -e

echo "开始清理 Ubuntu 系统..."

# 更新系统包列表
sudo apt update

# 删除不必要的包和依赖
sudo apt -y autoremove
sudo apt -y autoclean
sudo apt -y clean

# 清理日志文件
echo "清理日志文件..."
sudo find /var/log -type f -exec truncate -s 0 {} \;

# 清理 apt 缓存
echo "清理 APT 缓存..."
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt/*

# 删除用户历史记录
echo "清理用户历史记录..."
unset HISTFILE
sudo rm -f /root/.bash_history
sudo rm -f /home/*/.bash_history

# 清理临时文件
echo "清理临时文件..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# 重置机器 ID
echo "重置机器 ID..."
sudo truncate -s 0 /etc/machine-id
sudo rm -f /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

# 删除 swap 文件
echo "删除 swap 文件..."
sudo swapoff -a
sudo rm -f /swapfile
sudo rm -f /etc/fstab.swap

