node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {

        app = docker.build("akubrachenko/testjenkins:${env.BUILD_ID}")
    }

    stage('Test image') {

        app.inside {
            sh 'psql srmsystem -U root'
        }
    }

    /*stage('Push image') {
        docker.withRegistry('', 'docker_pass') {
            app.push()
        }
    }*/
}