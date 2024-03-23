pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'artifact.onwalk.net/public/base/alpine-ansible-lint:latest'
                    reuseNode true
                }
            }
            steps {
                sh 'gradle --version'
            }
        }
    }
    stages {
        stage('Pre Setup') {
            agent {
                docker {
                    image 'artifact.onwalk.net/public/base/alpine-ansible-lint:latest'
                    reuseNode true
                }
            }
            steps {
                sh "echo \"${secrets.ANSIBLE_SSH_PASSWORD}\" > ~/.vault_pass.txt"
                sh "echo 'ansible_password: \'xxxx\'' >> inventory/group_vars/all.yml"
                sh "echo 'ansible_become_password: \'xxxx\'' >> inventory/group_vars/all.yml"
            }
        }
    }
    stages {
        stage('Deploy') {
            agent {
                docker {
                    image 'artifact.onwalk.net/public/base/alpine-ansible-lint:latest'
                    reuseNode true
                }
            }
            steps {
                sh "ansible-playbook -u ${secrets.ANSIBLE_SSH_USER} -i inventor.ini -kK playbooks/server.yml -l ${params.instance_name} -e 'ign_install_ver=${params.install_version}' --vault-password-file .vault_pass.txt --diff"
            }
        }
    }
    stages {
        stage('Postsetup') {
            agent {
                docker {
                    image 'artifact.onwalk.net/public/base/alpine-ansible-lint:latest'
                    reuseNode true
                }
            }
            steps {
                sh "echo Todo"
            }
        }
    }
}
