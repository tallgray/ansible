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
          label 'ubuntu-ansible-jenkins-agent'
        }

      }
      steps {
        sh 'ansible-playbook /dev/site/_ping.yml '
      }
    }

  }
}