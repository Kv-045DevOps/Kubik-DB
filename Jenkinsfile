def buildResult
def paramss = ["GitHub/SRM-GET/PR-3", "GitHub/SRM-UI/test", "GitHub/SRM-DB/PR-2", "GitHub/SRM-POST/test"]
def dockerRegistry = "100.71.71.71:5000"
def Creds = "git_cred"
properties([
    parameters([
        stringParam(
            defaultValue: 'v2.0', 
            description: 'Current version', 
            name: 'imageTagGET_'),
        stringParam(
            defaultValue: 'v2.0', 
            description: 'Current version', 
            name: 'imageTagUI_'),
        stringParam(
            defaultValue: 'v2.0', 
            description: 'Current version', 
            name: 'imageTagDB_'),
        stringParam(
            defaultValue: 'v2.0', 
            description: 'Current version', 
            name: 'imageTagPOST_'),
        stringParam(
            defaultValue: '*', 
            description: 'E2E Test', 
            name: 'e2e_YAML')
    ])
])

node {
        stage('Build and push Docker images') {
            git(branch: "test", url: 'https://github.com/Kv-045DevOps/SRM-DB.git', credentialsId: "${Creds}")
            imageTagDB = sh (script: "git rev-parse --short HEAD", returnStdout: true)
            git(branch: "test", url: 'https://github.com/Kv-045DevOps/SRM-UI.git', credentialsId: "${Creds}")
            imageTagUI = sh (script: "git rev-parse --short HEAD", returnStdout: true)
            git(branch: "test", url: 'https://github.com/Kv-045DevOps/SRM-POST.git', credentialsId: "${Creds}")
            imageTagPOST = sh (script: "git rev-parse --short HEAD", returnStdout: true)
            git(branch: "master", url: 'https://github.com/Kv-045DevOps/Kubik-DB.git', credentialsId: "${Creds}")
            imageTagINI = (sh (script: "git rev-parse --short HEAD", returnStdout: true))
            git(branch: "test", url: 'https://github.com/Kv-045DevOps/SRM-GET.git', credentialsId: "${Creds}")
            imageTagGET = (sh (script: "git rev-parse --short HEAD", returnStdout: true))
            def jobs = [:]
            for(i = 0; i < paramss.size(); i += 1) {
                def param = paramss[i]
                jobs["Jobs_build_${i}"] = {
                    build job: param, parameters: [[$class: 'StringParameterValue', name: "imageTagGET_", value: "${imageTagGET}"],
						   [$class: 'StringParameterValue', name: "imageTagUI_", value: "${imageTagUI}"],
						   [$class: 'StringParameterValue', name: "imageTagDB_", value: "${imageTagDB}"],
						   [$class: 'StringParameterValue', name: "imageTagPOST_", value: "${imageTagPOST}"]], wait: true
                }
            }
            parallel jobs
        }
}
