pipeline {
    agent { docker { image 'kuritam/jenkins-operation' } }
    stages {
        stage('unit-test') {
            steps {
                sh 'npm --version'
            }
        }
        stage('unit test') {
            steps {
                sh 'echo test'

                publishHTML target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: 'dist',
                  reportFiles: 'index.html',
                  reportName: 'Converage Report'
                ]
            }
        }
    }
}
