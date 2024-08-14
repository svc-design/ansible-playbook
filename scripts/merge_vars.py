
import os
import sys
import yaml
import json

def check_env_vars(vars):
    """检查环境变量是否存在并且非空"""
    for var in vars:
        value = os.environ.get(var)
        if value is None or value == "":
            print(f"Error: Environment variable '{var}' is not set or is empty.")
            sys.exit(1)

def main():
    # 定义需要检查的环境变量
    required_vars = [
        "DOMAIN",
        "CLUSTER_NAME",
        "SUDO_PASSWORD",
        "GATEWAY_PRIVATE_KEY",
        "GATEWAY_PUBLIC_CONFIG"
    ]
    
    # 检查环境变量
    check_env_vars(required_vars)

    # 从环境变量获取输入
    domain = os.environ.get("DOMAIN")
    cluster_name = os.environ.get("CLUSTER_NAME")
    ansible_become_pass = os.environ.get("SUDO_PASSWORD")
    gateway_private_key = os.environ.get("GATEWAY_PRIVATE_KEY")
    gateway_public_config = os.environ.get("GATEWAY_PUBLIC_CONFIG")

    # 检查并去掉开头的 '$'
    if gateway_public_config.startswith('$'):
        gateway_public_config = gateway_public_config[1:]
    if gateway_private_key.startswith('$'):
        gateway_private_key = gateway_private_key[1:]

    # 将 gateway_public_config 转换为字典
    public_config_dict = yaml.safe_load(gateway_public_config)

    # 构建最终的配置字典
    final_config = {
        "domain": domain,
        "cluster_name": cluster_name,
        "ansible_become_pass": ansible_become_pass,
        "gateway": {
            "private_key": {
                "value": gateway_private_key
            },
            "public_config": public_config_dict
        }
    }

    # 输出为 JSON
    with open("extra_vars.json", "w") as json_file:
        json.dump(final_config, json_file, indent=2)

if __name__ == "__main__":
    main()
