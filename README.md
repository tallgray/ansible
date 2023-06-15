## Efficient Config Management with Ansible

End-to-end automation to configure hosts, containers, and deploy software. This project will be designed around a lab development environment consisting of six (6) virtual machine hosts: a workstation on Ubuntu desktop, a file server on CentOS, a Minikube install on Ubuntu, and three (3) Docker hosts on Ubuntu: a master and two workers. Initially, these applications will be deployed as containers: Grafana with Prometheus, Jenkins. 

# INVENTORY
The virtual machine host inventory will be as follows: 
HOSTNAME|FUNCTION 
ubuntu|workstation (will act as the sys admin node), 
samba1|file server, 
minik|minikube (cluster and docker compose node), 
docker|docker master, 
docker1|worker, 
docker2|worker 

The packages installed on each node are contained within the ansible playbooks.

# USER GUIDE
Create ssh key pair for your username and define a custom file name
  ssh-keygen -t ed25519 -C "<USERNAME1>" -f id_<USERNAME1>

Create ssh key pair for an automation role and define a custom file name
  ssh-keygen -t ed25519 -C "<USERNAME2>" -f id_<USERNAME2>

Display the key pairs and the public keys
  ls -la ~/.ssh
  cat ~/.ssh/id_*.pub

Create a github account and repository, add public SSH key to settings, and test access
https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account
https://docs.github.com/en/get-started/quickstart/create-a-repo (Select Initialize this repository with a README.)
https://docs.github.com/en/github-ae@latest/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
  ssh -T git@github.com

Clone the repository to your local machine. A sub-folder will be created matching the name of your repository and contain the README.md file.
  git clone git@github.com:tallgray/ansible.git

Change directory to the repository subfolder
  cd ansible
  ls -la

Get familiar with status, diff, add, commit and push commands used with git protocol
  git config --global user.name "Glenn Gray"
  git config --global user.email "tallgray1@gdom.local"
  git status
  git diff README.md
  git add README.md
  git status
  git commit -m "update to readme file"
  git push origin main

Scan for inventory hosts keys and add to known_hosts
  ansible-playbook _ssh_keyscan.yml

Copy public SSH key to inventory hosts authorized_keys file
  ansible-playbook _bootstrap.yml -k -K

It is assumed that the hosts in INVENTORY are accessible via SSH by a sudo user from the machine you are starting from. The _site_before_roles.yml is a single playbook format for establishing the baseline setup of all hosts. The site.yml file along with directories: host_vars and roles represent a 'best practices' approach to efficient configuration management with Ansible.
