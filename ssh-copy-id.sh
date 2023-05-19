#!/bin/bash

# Define the list of hostnames
hostnames=("kali" "k8s" "git1" "docker2" "minikube" "ansible" "serverless" "ansible-aap" "docker" "localhost")
username="tallgray1"
read -s -p "Enter the password: " password
echo

# Iterate through the hostnames
for hostname in "${hostnames[@]}"
do
    # Run ssh-copy-id for each hostname
    sshpass -p "$password" ssh-copy-id "$username@$hostname"
done