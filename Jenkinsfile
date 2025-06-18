pipeline {
    agent any

    environment {
        GITHUB_REPO = "https://github.com/patthechosen/Jenkins.git"
        DOCKERHUB_REPO = "patthechosen/pat_jenkins_apache"
        DOCKERHUB_CREDS = credentials('DockerhubCreds-id')
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', credentialsId: 'GithubCredsok', url: "${GITHUB_REPO}"
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image with Apache and custom index.html"
                sh "docker build -t ${DOCKERHUB_REPO}:v${BUILD_NUMBER} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo "Logging into Docker Hub"
                sh "echo ${DOCKERHUB_CREDS_PSW} | docker login -u ${DOCKERHUB_CREDS_USR} --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "Pushing image to Docker Hub"
                sh "docker push ${DOCKERHUB_REPO}:v${BUILD_NUMBER}"
            }
        }

        stage('Run Container') {
            steps {
                echo "Launching container with Apache and your GitHub index.html"
                sh "docker rm -f pat_apache || true"
                sh "docker run -d -p 80:80 --name pat_apache ${DOCKERHUB_REPO}:v${BUILD_NUMBER}"
                sh "docker ps -f name=pat_apache"
            }
        }

        stage('Verify Apache') {
            steps {
                echo "Checking Apache from inside container"
                script {
                    def status = sh(
                        returnStatus: true, 
                        script: 'docker exec pat_apache curl -s -o /dev/null -w "%{http_code}" http://localhost'
                    )
                    if (status == 200) {
                        echo "✅ Apache inside container is working"
                    } else {
                        error "❌ Apache inside container is not responding (HTTP ${status})"
                    }
                }
            }
        }
    }
}