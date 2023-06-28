pipeline {
  agent any
  stages {
    stage('Build Image') {
      steps {
        git(url: 'https://github.com/tallgray/ansible', branch: 'main')
      }
    }

  }
}