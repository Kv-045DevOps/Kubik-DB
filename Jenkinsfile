// node {
//     def app

//     // Checking, that the repository was cloned to workspace
//     stage('Clone repository') {
        
//         checkout scm
//         gitTag = sh (script: "git rev-parse --short HEAD", returnStdout: true)

//     }

//     //Push to claster
// }
def label = "mypod-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true)
], serviceAccount: "jenkins") 
{

def Creds = "git_cred"
def imageTag


node(label)
{
    try{
        stage("Git Checkout"){
            git(
                branch: "master",
                url: 'https://github.com/Kv-045DevOps/Kubik-DB.git',
                credentialsId: "${Creds}")
            imageTag = sh (script: "git rev-parse --short HEAD", returnStdout: true)
        }
        stage("Deploy to Kubernetes"){
			container('kubectl'){
				sh "kubectl apply -f template.yaml"
				sh "kubectl get pods --namespace=production"
			}
        }
    catch(err){
        currentBuild.result = 'Failure'
    }
}
}


sleep 30
