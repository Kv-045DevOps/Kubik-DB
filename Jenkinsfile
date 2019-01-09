node {
    def app

    // Checking, that the repository was cloned to workspace
    stage('Clone repository') {
        
        checkout scm
    }
    // Build docker image
    stage('Build image') {

        app = docker.build("akubrachenko/testjenkins:${env.GIT_COMMIT}")
    }
    // Check dump file
    stage('Test image') {
        app.inside {
            sh 'dir /tmp'
        }
    }
    // Push image to the docker hub
    stage('Push image') {
        docker.withRegistry('', 'docker_pass') {
            app.push()
        }
    }
}