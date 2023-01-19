#!/bin/bash

required_base_env_vars="CORALOGIX_PRIVATE_KEY CORALOGIX_URL AZURE_INTEGRATION AZURE_REGION"

#Function to validate required variables are set
check_vars()
{
    var_names=("$@")
    for var_name in "${var_names[@]}"; do
      if [ -z "${!var_name}" ]
      then
        echo "Required variable $var_name is unset."
        var_unset=true
      fi
    done
    if [ -n "$var_unset" ]
    then
      echo "Please ensure you use '--env-file env.vars' when running the docker container"
      echo "Exiting"
      exit 1
    fi
    echo "All required base variables are set."
    return 0
}

check_fault () {
    if ! [ $? -eq 0 ]
    then
        exit 1
    fi
}

check_vars $required_base_env_vars
git clone https://github.com/coralogix/coralogix-azure-serverless.git
cd coralogix-azure-serverless
if [[ -v GIT_BRANCH ]]; then
  echo "Checking out git branch: $GIT_BRANCH"
  git checkout $GIT_BRANCH
  check_fault
fi
cd $AZURE_INTEGRATION
if [ -f docker_deploy.sh ]; then
	bash docker_deploy.sh
else
	echo "No docker_deploy.sh script found in the provided integration subfolder: $AZURE_INTEGRATION"
	exit 1
fi
