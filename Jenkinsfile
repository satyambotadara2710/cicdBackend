def DOCKER_REPO = 'satyambotadara2710'
def IMAGE_NAME = 'crudspring'
def PORT = 8080
def CONTAINER_NAME = 'cicdBackend'

pipeline {
    
    agent any
    
    parameters {
        string(name: 'imageVersion', defaultValue: '1', description: 'image version')
    }

    environment {
        DOCKERHUB_CRED = credentials('docker-hub-cred')
    }
    
    stages {
        stage("clean workspace"){
            steps{
                cleanWs()
            }
        }
        stage("checkout") {
            tools {git 'Default'}
            steps {
                git branch: 'main', credentialsId: 'backend-git-token', url: 'https://github.com/satyambotadara2710/cicdBackend.git'
            }
        }
        stage("build docker image") {
            steps {
                bat "docker build -t ${DOCKER_REPO}/${IMAGE_NAME}:${params.imageVersion} -t ${DOCKER_REPO}/${IMAGE_NAME}:latest ."
            }
        }
        stage("push image to dockerhub") {
            steps {
                //   login into docker hub
                bat " docker login -u $DOCKERHUB_CRED_USR -p $DOCKERHUB_CRED_PSW"
                bat "docker push -a ${DOCKER_REPO}/${IMAGE_NAME}"

            }
        }
    }
    
    post {
        always {
             bat "docker pull ${DOCKER_REPO}/${IMAGE_NAME}"
             bat ".\\runcontainer.bat ${PORT} $CONTAINER_NAME  $DOCKER_REPO/$IMAGE_NAME"
        }
    }
}