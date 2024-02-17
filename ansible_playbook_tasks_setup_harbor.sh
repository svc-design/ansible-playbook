#!/bin/bash

# Function to check if a variable is empty
check_empty() {
    if [ -z "${!1}" ]; then
        echo "$1 is empty. Aborting."
        exit 1
    fi
}

# List of variables to check
variables=("DOMAIN")

# Loop through variables and check if each one is empty
for var in "${variables[@]}"; do
    check_empty "$var"
done

cat > init-harbor-server << EOF
- name: setup harbor 
  hosts: all
  user: root
  become: yes
  gather_facts: yes
  tasks:
    - include_role:
        name: harbor
      vars:
        group: master
        namespace: harbor
        domain: ${DOMAIN}
        db_namespace: database
        vault: false
        auto_issuance: false
        update_secret: true
        storage_type: oss
        tls:
          - secret_name: harbor-tls
            keyfile: /etc/ssl/${DOMAIN}.key
            certfile: /etc/ssl/${DOMAIN}.pem
EOF
