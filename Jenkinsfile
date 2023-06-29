pipeline {
  agent any
  stages {
    stage('Checkout Code') {
      steps {
        git(url: 'https://github.com/tallgray/ansible', branch: 'main')
      }
    }

    stage('Ping Inventory') {
      steps {
        sh 'ansible-playbook _ping.yml '
      }
    }

  }
}