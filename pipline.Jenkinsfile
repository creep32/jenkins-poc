node {
  String payload = "${payload}"
    def jsonObject = readJSON text: payload
    String gitURl = "${jsonObject.repository.clone_url}"
    String gitHash = "${jsonObject.pull_request.head.sha}"

    try {
      stage('Preparation') { // for display purposes
        withEnv(["GITHASH=$gitURl"]) {
          echo "$GITHASH"
            sh "echo ${GITHASH}"
            sh "git clone ${GITHASH} cloned"
            sh "ls -la cloned"
        }
      }
      def file = fileExists 'cloned/ci/test.sh'

        if (file) {
          stage("Test") {
            withEnv(["GITHASH=$gitURl"]) {
              dir("cloned/ci") {
                sh'''
                  bash test.sh $GITHASH
                  '''
              }
            }
          }
        }
      file = fileExists 'cloned/ci/deploy.sh'
      if (file) {
        stage("deploy") {
          withEnv(["GITHASH=$gitURl"]) {
            dir("cloned/ci") {
              sh'''
                bash deploy.sh $GITHASH
                '''

                if (fileExists('dest')) {
                  publishHTML (target: [
                      allowMissing: true,
                      alwaysLinkToLastBuild: false,
                      keepAll: true,
                      reportDir: 'dest/yes',
                      reportFiles: 'index.html',
                      reportName: "RCov Report"
                  ])
                }
            }
          }
        }
      }
      stage('Results') {
        dir('cloned') {
          archiveArtifacts 'README.md'
        }
      }
      String gitStatusPostUrl = "https://fcda86f3c3a85b3f8d192b818388eb2d17837ed2:x-oauth-basic@api.github.com/repos/creep32/jenkins-poc/${gitHash}"
      stage("pull request status update") {
        withEnv(["GURL=$gitStatusPostUrl"]) {
        sh """
        curl -X POST -H "application/json" -d '{"state":"success", "target_url":"${BUILD_URL}", "description":"Build Success", "context":"build/job"}' "${GURL}"
        """
      }
      }
    } catch (e) {
      throw e
    } finally {
      echo "post hook"
        sh "rm -rf cloned"
    }
}
