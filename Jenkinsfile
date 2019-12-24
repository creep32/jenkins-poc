pipeline {
    agent { docker { image 'node:6.3' } }
    stages {
        stage('build') {
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
