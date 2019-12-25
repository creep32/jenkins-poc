pipeline {
    agent { docker { image 'kuritam/jenkins-operation' } }
    stages {
        stage('unit-test') {
            steps {
                dir('./rest-api/docker-compose/') {
                  sh 'docker-compose -f docker-compose-test.yml build'
                  sh 'docker-compose -f docker-compose-test.yml run unit'
                  publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'artifact/coverage/',
                    reportFiles: '*',
                    reportName: 'Converage Report'
                  ]
                }
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
