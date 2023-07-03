pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      steps {
        git(url: 'https://github.com/tallgray/ansible', branch: 'main')
      }
    }

    stage('Ping Inventory') {
      agent {
        node {
          label 'agent-perm-ubuntu-ansible'
        }

      }
      steps {
        sh 'ansible-playbook _ping.yml '
        ansiblePlaybook(playbook: '_ping.yml', inventory: 'inventory')
      }
    }

  }
}
