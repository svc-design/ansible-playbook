def checkoutCode() {
    stage('Checkout repository and submodules') {
        agent {
            docker { image 'your-docker-image' }
        }
        steps {
            checkout scm
        }
    }
}

def preSetup() {
    stage('Pre Setup') {
        agent {
            docker { image 'your-docker-image' }
        }
        steps {
            script {
                sh "echo \"${secrets.ANSIBLE_SSH_PASSWORD}\" > ~/.vault_pass.txt"
                sh "echo 'ansible_password: \'xxxx\'' >> inventory/group_vars/all.yml"
                sh "echo 'ansible_become_password: \'xxxx\'' >> inventory/group_vars/all.yml"
            }
        }
    }
}

def deploy() {
    stage('Deploy Ignition Server') {
        agent {
            docker { image 'your-docker-image' }
        }
        steps {
            script {
                sh "export ANSIBLE_HOST_KEY_CHECKING=False"
                sh "ansible-playbook -u ${secrets.ANSIBLE_SSH_USER} -i inventor.ini -kK playbooks/server.yml -l ${params.instance_name} -e 'ign_install_ver=${params.install_version}' --vault-password-file .vault_pass.txt --diff"
            }
        }
    }
}

def postSetup() {
    stage('Post Setup') {
        agent {
            docker { image 'your-docker-image' }
        }
        steps {
            script {
                sh "export ANSIBLE_HOST_KEY_CHECKING=False"
            }
        }
    }
}

def check() {
    stage('Check') {
        agent {
            docker { image 'your-docker-image' }
        }
        steps {
            script {
                // Add your check logic here
            }
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Deploy Pipeline') {
            steps {
                checkoutCode()
                preSetup()
                deploy()
                postSetup()
                check()
            }
        }
    }
}
