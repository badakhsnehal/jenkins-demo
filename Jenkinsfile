// Jenkinsfile (Declarative)
pipeline {
  agent { label 'builtin' }                 // use your builtin agent label
  environment {
    REPO       = 'https://github.com/badakhsnehal/jenkins-demo.git'
    BRANCH     = 'main'
    IMAGE      = 'my-node-app'
    CONTAINER  = 'nodeserver'
    DEV_EMAIL  = 'snehalbadakh2004@gmail.com' // email to notify on failure
  }

  stages {
    stage('Checkout') {
      steps {
        echo "Cloning ${REPO} (branch ${BRANCH})"
        git branch: "${BRANCH}", url: "${REPO}"
      }
    }

    stage('Build Docker image') {
      steps {
        echo "Building Docker image ${IMAGE}"
        // prefer the Dockerfile in repo; fallback t'https://github.com/ajay-raut/spnodeserver.git'o simple build command
        sh 'docker --version || true'
        sh "docker build -t ${IMAGE} ."
      }
    }

    stage('Run container') {
      steps {
        echo "Starting container ${CONTAINER} from image ${IMAGE} (port 5000)"
        // run detached, map port 5000
        sh "docker run -d --name ${CONTAINER} -p 5000:5000 ${IMAGE} || true"
        // wait for the app to be ready (assignment needs a 10s wait)
        sh 'sleep 10'
        // show running containers (explicit requirement)
        echo "Running containers (before stopping):"
        sh 'docker ps -a'
        // stop and remove container
        echo "Stopping and removing container ${CONTAINER}"
        sh "docker stop ${CONTAINER} || true"
        sh "docker rm ${CONTAINER} || true"
      }
    }
  }https://github.com/badakhsnehal/jenkins-demo

  post {
    failure {
      echo "Build failed — sending email to ${DEV_EMAIL}"
      // Requires Email Extension plugin (emailext) and SMTP configured in Jenkins
      emailext(
        subject: "Jenkins: Build FAILED - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
        body: """Build URL: ${env.BUILD_URL}
Job: ${env.JOB_NAME}
Build number: ${env.BUILD_NUMBER}
Console: ${env.BUILD_URL}console
-- Automated notification from Jenkins --
""",
        to: "${DEV_EMAIL}"
      )
    }
    always {
      // useful to leave evidence in logs
      echo "Final docker ps -a (post)"
      sh 'docker ps -a || true'
    }
  }
}
