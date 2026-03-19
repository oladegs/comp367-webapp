pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

    tools {
        maven 'MAVEN'
    }

    environment {
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
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
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