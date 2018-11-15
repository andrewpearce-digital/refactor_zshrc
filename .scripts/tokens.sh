#!/bin/bash

# Reset any existing expired AWS Environment variables so
# we drop to ~/.aws credentials to generate.
set_aws_credentials(){
  local access_credentials
  local ARN
	ARN=$(arn "$SOURCE_PROFILE" | sed 's/user/mfa/')

  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  unset AWS_PROFILE

	printf "Source Profile (e.g. opg-shared): "
  read -r SOURCE_PROFILE
  printf "\\nAssume Role (e.g. opg-shared-non-sc): "
  read -r ASSUME_PROFILE
  printf "\\nMFA Token: "
  read -s -r TOKEN
  printf "\\n"

  access_credentials=$(aws sts get-session-token --duration-seconds 28800 \
                                           --serial-number "$ARN" \
                                           --profile "$SOURCE_PROFILE" \
                                           --token-code "$TOKEN" \
                                           --output json)

  AWS_ACCESS_KEY_ID=$(echo "$access_credentials" | jq ".Credentials.AccessKeyId" | tr -d \")
	export AWS_ACCESS_KEY_ID

  AWS_SECRET_ACCESS_KEY=$(echo "$access_credentials" | jq ".Credentials.SecretAccessKey" | tr -d \")
  export AWS_SECRET_ACCESS_KEY
  
	AWS_SESSION_TOKEN=$(echo "$access_credentials" | jq ".Credentials.SessionToken" | tr -d \")
  export AWS_SESSION_TOKEN

  echo "Session Expires at $(echo "$access_credentials" | jq ".Credentials.Expiration" | tr -d \")"
  echo "Setting AWS_PROFILE to $ASSUME_PROFILE"
  export AWS_PROFILE="$ASSUME_PROFILE"
}

unset_aws_credentials(){
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}

arn(){
  aws sts get-caller-identity --output text --query 'Arn' --profile "$1"
}
