#!/bin/bash

curl -L -o aws-env https://github.com/Droplr/aws-env/raw/master/bin/aws-env-linux-amd64
chmod +x ./aws-env
echo "Branch is $CI_BRANCH"
eval $(AWS_ENV_PATH=/dev/partnerships/ AWS_REGION=us-east-1 ./aws-env)
echo "Test one is $DEV_ETL_SERVER"
if [[ $CI_BRANCH =~ .*beta ]]
then
    echo "There's beta!"
elif [[ $CI_BRANCH =~ .*staging ]]
then
    echo "There's staging!"
elif [[ $CI_BRANCH =~ .*master ]]
then
    echo "There's master!"
else
    echo "None of the above!"
fi