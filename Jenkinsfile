pipeline {
    agent any

    tools {
        maven 'MAVEN'
    }

    environment {
        DOCKERHUB_PWD = credentials('CredentialID_DockerHubPWD')
        DOCKERHUB_USER = 'oladegs'
        IMAGE_NAME = 'comp367-webapp'
        IMAGE_TAG = '1.0'
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
                bat 'docker login -u %DOCKERHUB_USER% -p %DOCKERHUB_PWD%'
            }
        }

        stage('Docker build') {
            steps {
                bat 'docker build -t %DOCKERHUB_USER%/%IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Docker push') {
            steps {
                bat 'docker push %DOCKERHUB_USER%/%IMAGE_NAME%:%IMAGE_TAG%'
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
    }
}