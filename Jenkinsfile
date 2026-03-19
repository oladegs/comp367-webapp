pipeline {
    agent any

    tools {
        maven 'MAVEN'
    }

    environment {
        DOCKERHUB_PWD = credentials('CredentialID_DockerHubPWD')
        IMAGE_NAME = 'oladegs/comp367-webapp:1.0'
    }

    stages {
        stage('Check out') {
            steps {
                git branch: 'main', url: 'https://github.com/oladegs/comp367-webapp.git'
            }
        }

        stage('Build maven project') {
            steps {
                bat 'mvn -B clean package'
            }
        }

        stage('Docker login') {
            steps {
                bat '@echo %DOCKERHUB_PWD% | docker login -u oladegs --password-stdin'
            }
        }

        stage('Docker build') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Docker push') {
            steps {
                bat 'docker push %IMAGE_NAME%'
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
    }
}