pipeline {
  agent agent-perm-ubuntu-ansible
  stages {
    stage('Checkout Code') {
      steps {
        git(url: 'https://github.com/tallgray/ansible', branch: 'main')
      }
    }

    stage('Ansible Ping Inventory') {
      agent {
        node {
          label 'agent-perm-ubuntu-ansible'
        }

      }
      steps {
        ansiblePlaybook credentialsId: 'agent-perm-ubuntu-ansible-sshkey', installation: 'Ansible Controller', inventory: '/home/ansible/ansible/inventory', playbook: '/home/ansible/ansible/_ping.yml'
      }
    }

  }
}
