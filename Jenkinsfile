pipeline {
    agent { docker { image 'node:6.3' } }
    stages {
        stage('build') {
            steps {
                sh 'npm --version'
            }
        }
    }
    post {
      always {
        jest 'dist/index.html'
      }
    }
}
