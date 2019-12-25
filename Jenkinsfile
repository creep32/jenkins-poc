pipeline {
   // agent { docker { image 'kuritam/jenkins-operation' } }
    agent any
    stages {
        stage('unit-test') {
            steps {
                dir('./rest-api/docker-compose/') {
                  sh 'docker-compose -f docker-compose-unit.yml build'
                  sh 'docker-compose -f docker-compose-unit.yml run unit'

                  publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'artifact/coverage/lcov-report/',
                    reportFiles: '*',
                    reportName: 'Unit test Converage Report'
                  ]

                  archive (includes: 'artifact/coverage/**')
                }
            }
        }
       stage('integrate test') {
            steps {
                dir('./rest-api/docker-compose/') {
                  sh 'rm -rf artifact/*'
                  sh 'docker-compose -f docker-compose.yml -f docker-compose-local.yml run wait_es'
                  sh 'docker-compose -f docker-compose.yml -f docker-compose-local.yml build restapi'
                  sh 'docker-compose -f docker-compose.yml -f docker-compose-local.yml run wait_restapi'
                  sh 'docker-compose -f docker-compose-test.yml build'
                  sh 'docker-compose -f docker-compose-test.yml run integrate'

                  publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'artifact/coverage/lcov-report/',
                    reportFiles: '*',
                    reportName: 'inegrate test Converage Report'
                  ]

                  archive (includes: 'artifact/coverage/**')
                }

            }
        }
    }
}
