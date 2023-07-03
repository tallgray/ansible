pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      agent any
      steps {
        git(url: 'https://github.com/tallgray/ansible', branch: 'main')
      }
    }

    stage('Ansible Ping Inventory') {
      agent any
      steps {
        ansiblePlaybook(credentialsId: 'agent-perm-ubuntu-ansible-sshkey', installation: 'Ansible Controller', inventory: 'inventory', playbook: '_ping.yml')
      }
    }

  }
}