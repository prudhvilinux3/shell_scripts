#!/bin/bash
#
#################################################
#Author: Prudhvi B
#Date: 29-10-2025
#Purpose: Get list of repos of a user and get their created time. 
################################################
#
#
# Let's debug, comment back when done. Otherwise it will expose the token !! 
#set -x 
set -e 

#set url for the github api 
API_URL="https://api.github.com"

#Improt the username and token
USERNAME=$username
TOKEN=$token

#Get the input variable of the user name
GIT_USER=$1

#echo $USERNAME
#echo $TOKEN
#echo $GIT_USER

function helper {
	arg_count=1
	if [[ $# -ne $arg_count ]] ; then
		echo " Invalid usage " 
		echo " Please input the Git user to list the repos"
		exit 1
	fi
}

function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}


function list_repos_for_user {
	local endpoint="users/${GIT_USER}/repos"
	list_repos="$(github_api_get "$endpoint" | jq -r '.[] | "\(.name)\t\(.owner.login)\t\(.created_at)"' |column -t)"
	 echo -e "RepoName\t\t\t\tOwner\t\tCreatedAt"
	echo "$list_repos"
}
helper "$@"
list_repos_for_user
