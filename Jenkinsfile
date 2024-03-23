@Library('pipeline-library') _

pipeline {
    agent any
    stages {
        stage('Deploy Pipeline') {
            steps {
                ansibleSteps.checkoutCode()
                ansibleSteps.preSetup("${secrets.ANSIBLE_SSH_PASSWORD}")
                ansibleSteps.deploy("${secrets.ANSIBLE_SSH_USER}", "${input.instance_name}", "${input.install_version}")
                ansibleSteps.postSetup()
                ansibleSteps.check()
            }
        }
    }
}
