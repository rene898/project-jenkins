pipeline{
    agent any
    triggers{
        githubPush()
    }
    stages {
        stage('Checkout'){
            steps {
                script {
                        sh 'git reset --hard'
                        def gitUrl = 'https://github.com/rene898/project-jenkins.git'
                        def branch = 'main'
                        sh 'git pull origin main'
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh '''
                    docker run --rm -v $PWD:/app -w /app node:18-alpine sh -c "npm install --legacy-peer-deps"
                    '''
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    sh '''
                    docker run --rm -v $PWD:/app -w /app node:18-alpine sh -c "npm run build"
                    '''
                }
            }
        }
        stage('Run Unit Tests') {
            steps {
                script {
                    sh '''
                    docker run --rm -v $PWD:/app -w /app node:18-alpine sh -c "npm test todo.test.js"
                    '''
                }
            }
        }
        stage('Run Integration Tests') {
            steps {
                script {
                    sh '''
                    docker run --rm -v $PWD:/app -w /app node:18-alpine sh -c "npm test todoList.integration.test.js"
                    '''
                }
            }
        }
         stage('Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-react-app .'
                }
            }
        }
         stage('Deploy') {
            steps {
                script {
                    sh '''
                    sudo docker stop react-app || true 
                    sudo docker rm react-app || true 
                    sudo docker run -d --name react-app -p 80:80 my-react-app 
                    sudo docker ps -a 
                    sudo docker logs react-app || true 
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Build, test, and deployment succeded'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}