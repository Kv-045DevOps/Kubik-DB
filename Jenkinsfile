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
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-)test */

        app.inside {
            sh 'psql srmsystem'
            sh '\d'
        }
    }

    /*stage('Push image') {
        docker.withRegistry('', 'docker_pass') {
            app.push()
        }
    }*/
}