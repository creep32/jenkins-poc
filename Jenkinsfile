pipeline {
   // agent { docker { image 'kuritam/jenkins-operation' } }
    agent any
    stages {
        stage('unit-test') {
            steps {
                dir('./rest-api/dockerlized-test/') {
                  sh 'bash run.sh -p unit unit-ci run'

                  publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: 'artifact/unit/coverage/lcov-report/',
                    reportFiles: '*',
                    reportName: 'Unit test Converage Report'
                  ]
                  sh 'bash run.sh -p unit unit-ci down'

                  archive (includes: 'artifact/unit/coverage/**')
                }
            }
        }
        stage('integrate test') {
             steps {
                 dir('./rest-api/dockerlized-test/') {
                   sh 'bash run.sh -p integrate integrate-ci run'

                   publishHTML target: [
                     allowMissing: false,
                     alwaysLinkToLastBuild: false,
                     keepAll: true,
                     reportDir: 'artifact/integrate/coverage/lcov-report/',
                     reportFiles: '*',
                     reportName: 'Unit test Converage Report'
                   ]
                   sh 'bash run.sh -p integrate integrate-ci down'

                   archive (includes: 'artifact/integrate/coverage/**')
             }
         }
      }
   }
}
