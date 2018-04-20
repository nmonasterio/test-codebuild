#!/bin/bash

echo $"AWS_REGION"

BRANCH=`git branch -a --contains $CODEBUILD_SOURCE_VERSION | sed -n 2p || $CODEBUILD_SOURCE_VERSION`
export CI_BRANCH="$BRANCH"
echo "$CI_BRANCH"
curl -L -o aws-env https://github.com/Droplr/aws-env/raw/master/bin/aws-env-linux-amd64
chmod +x ./aws-env

SECRETS_PREFIX=""
[[ $CI_BRANCH =~ .*beta ]] && { SECRETS_PREFIX="dev"; true; } || true;
[[ $CI_BRANCH =~ .*staging ]] && { SECRETS_PREFIX="staging"; true; } || true;
[[ $CI_BRANCH =~ .*master ]] && { SECRETS_PREFIX="master"; true; } || true;
export AWS_ENV_PATH="/$SECRETS_PREFIX/partnerships/"

[ -n "$SECRETS_PREFIX" ] && { eval $(./aws-env); npm init --force; true; } || echo "Not building from a branch that requires envs"; true;
