pipeline {
    agent none
    options {
        dockerPipeline {
            image 'artifact.onwalk.net/public/base/alpine-ansible-lint:latest'
        }
    }
    stages {
        stage('Checkout repository and submodules') {
            steps {
                checkout scm
            }
        }
        stage('Pre Setup') {
            steps {
                script {
                    sh "echo \"${secrets.ANSIBLE_SSH_PASSWORD}\" > ~/.vault_pass.txt"
                    sh "echo 'ansible_password: \'xxxx\'' >> inventory/group_vars/all.yml"
                    sh "echo 'ansible_become_password: \'xxxx\'' >> inventory/group_vars/all.yml"
                }
            }
        }
        stage('Deploy Ignition Server') {
            steps {
                script {
                    sh "export ANSIBLE_HOST_KEY_CHECKING=False"
                    sh "ansible-playbook -u ${secrets.ANSIBLE_SSH_USER} -i inventor.ini -kK playbooks/server.yml -l ${params.instance_name} -e 'ign_install_ver=${params.install_version}' --vault-password-file .vault_pass.txt --diff"
                }
            }
        }
        stage('Post Setup') {
            steps {
                script {
                    sh "export ANSIBLE_HOST_KEY_CHECKING=False"
                }
            }
        }
        stage('Check') {
            steps {
                script {
                    // Add your check logic here
                }
            }
        }
    }
}
