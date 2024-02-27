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

cat > init_keycloak_server << EOF
- name: setup keycloak server
  hosts: all
  user: root
  become: yes
  gather_facts: yes
  tasks:
    - include_role:
        name: keycloak 
      vars:
        group: master
        namespace: keycloak
        db_namespace: database
        vault: false
        auto_issuance: false
        update_secret: true
        tls:
          - secret_name: keycloak-tls
            keyfile: /etc/ssl/${DOMAIN}.key
            certfile: /etc/ssl/${DOMAIN}.pem
EOF
