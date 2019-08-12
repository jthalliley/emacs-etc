#----------------------------------------------------------------------------------------
#  Deploys 1 ear file from earDir using username and password.
#  Assumes "ear" is simple name for that ear,
#  which corresponds to the server name to which it is to be deployed.
#----------------------------------------------------------------------------------------
DeployEar() {
    ear=$1
    earDir=$2
    username=$3
    password=$4

    appName=$ear
    fullEarPath=${earDir}/${ear}.ear
    serverName=${ear}_a
    hostname=$(uname -n)

    if [ ! -f $fullEarPath ] ;then
        Error "No such file to deploy: $fullEarPath"
    fi

    java weblogic.WLST <<END_OF_PYTHON_SCRIPT
connect('${username}', '${password}', 't3://${hostname}:7001')

try:
    stopApplication('$appName')
    undeploy('$appName')
except Exception:
    print '--> App $appName was not running'

deploy('$appName', '$fullEarPath', targets='$serverName')
disconnect()
exit()

END_OF_PYTHON_SCRIPT
}

#----------------------------------------------------------------------------------------
#  Copy and rename ear files to deploy directory.
#----------------------------------------------------------------------------------------
CopyAndSimplifyEarFiles() {
    fromDir=$1
    toDir=$2

    allEars=$(find $fromDir/ -name *.ear -a -type f)

    for earFile in $allEars ;do
        simpleEarFileName=$(SimpleEarFileName $earFile)
        cp -f $earFile $toDir/${simpleEarFileName}
    done
}


#----------------------------------------------------------------------------------------
#  When we build .ear files, they are built with names like
#        caps2/steps-dealertrack-ear/target/stepsdealertrack-ear-1.0-SNAPSHOT.ear
#  but we want deploy scripts to see them as
#        caps2/stepsdealertrack.ear
#  so we fix that here.
#----------------------------------------------------------------------------------------
SimpleEarFileName() {
    earFile=$1

    simpleEarFileName=$(echo $(basename $earFile) | awk 'BEGIN {FS="-"} {print $1}').ear

    echo $simpleEarFileName
}
