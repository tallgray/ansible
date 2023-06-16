# EFFICIENT CONFIG MANAGEMENT WITH ANSIBLE by SITE

End-to-end automation to deploy software, configure users, maintain hosts, structure containers, and more! This project will be designed around a lab development environment consisting of six (6) virtual machine hosts: a workstation on Ubuntu desktop, a file server on CentOS, a Minikube install on Ubuntu, and three (3) Docker hosts on Ubuntu: a master and two workers. The `_site_before_roles.yml` is a single playbook format for establishing the baseline setup of all hosts. This is <span style="color:red">**NOT**</span> the way to efficiently model configuration management with Ansible. As such, the `site.yml` file along with sub-directories `host_vars` and `roles` represent a 'best practices' model of efficient configuration management with Ansible. By comparing the two, you may gain practical working knowledge of how to experiment and work with the two models in order to develop your Ansible skills.

<span style="font-family:Papyrus; font-size:2em;">*Note: regarding this project, you may want to refer to the **assumptions at the bottom** of the page OR the links below to my articles and videos, which can provide additional context, relevence and practicality of the use-case scenarios.*</span>

<span style="font-family:Papyrus; font-size:2em;">[Efficient Config Management with Ansible: From SSH Setup to Playbook Optimization](https://www.linkedin.com/pulse/efficient-config-management-ansible-from-ssh-setup-playbook-gray?trackingId=s7Zj7WBuQYG256WCsXQNQQ%3D%3D&lipi=urn%3Ali%3Apage%3Ad_flagship3_detail_base%3BISl%2Fxg1GSqa5jFSaK9zuVA%3D%3D)</span>

## VIRTUAL MACHINE HOST INVENTORY (HOSTNAME | FUNCTION | OS | RECOMMENDED):
  - `ubuntu` | workstation | Ubuntu | 2vCPU/2GigMem (will act as the sys admin node)
  - `samba1` | file server | CentOS | 2vCPU/2GigMem
  - `minik` | minikube | Ubuntu  | 4vCPU/6GigMem (will act as cluster and docker compose node)
  - `docker` | docker master | Ubuntu | 2vCPU/2GigMem
  - `docker1` | worker | Ubuntu | 2vCPU/2GigMem
  - `docker2` | worker | Ubuntu | 2vCPU/2GigMem

The packages installed on each node are installed by the Ansible playbooks. You can vary the hostnames and OS, but the playbooks will need to be modified accordingly.

## CONTAINERIZED APPLICATION IMAGE MANIFEST (REPOSITORY):
<span style="font-family:Papyrus; font-size:2em;">*Note: the (link) is a container image with applications used for DevOps automation and site administration*</span>
  - Grafana with Prometheus ([TBD](https://hub.docker.com/u/tallgray))
  - Jenkins ([TBD](https://hub.docker.com/u/tallgray))

## ENVIRONMENT SETUP & USAGE GUIDE:
1. Create the 6 virtual machines with hostnames and operating systems listed under 'VIRTUAL MACHINE HOST INVENTORY (HOSTNAME | FUNCTION | OS)'.
3. Create a GitHub account and repository. Once you've created your new repository, view it and select the `Code` drop down and make a note of its link under the `SSH` tab.
  - [Signing up for a GitHub account](https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account)
  - [Creating a repository](https://docs.github.com/en/get-started/quickstart/create-a-repo) (Give it a name of your choosing, select *"Initialize this repository with a README"*, and type in 'Hello'. You can customize it later.)
4. Connect to the workstation host and create a user with sudo permission (provided you are root OR your account has sudo permissions).
  - 'useradd ansible'
  - 'usermod -aG sudo ansible'
5. Assume the new user and create SSH key pair for an automation role and define a custom file name.
  - 'su - ansible'
  - 'ssh-keygen -t ed25519 -C "ansible" -f id_ansible'
6. Confirm creation of the key pairs and display the public key.
  - 'ls -la ~/.ssh'
7. Install Git and Ansible package from apt repository.
  - 'sudo apt -y install git'
  - 'sudo apt -y install ansible'
8. Display the public SSH key and add it to your GitHub account through `settings` (top right drop-down) then `SSH and GPG keys`, test access from shell console, and configure it.
  - 'cat ~/.ssh/id_ansible.pub'
  - [Adding a new SSH key to your GitHub account](https://docs.github.com/en/github-ae@latest/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
  - 'ssh -T git@github.com'
  - 'git config --global user.name "Your Name"'
  - 'git config --global user.email "your@email.com"'
9. Clone this project repository to your local machine that that is now running Git and Ansible. Note: a new sub-folder will be created in whatever directory you are currently in and it will match the name of this repository and contain its entire directory structure and file content.
  - 'git clone git@github.com:tallgray/ansible.git'
10. Change the directory to the repository subfolder.
  - 'cd ansible/dev/site'
11. Scan for inventory host keys and add them to your known_hosts file.
  - 'ansible-playbook _ssh_keyscan.yml'
12. Copy the public SSH key we created in step 5 to all inventory hosts authorized_keys file.
  - 'ansible-playbook _bootstrap.yml -k -K'
13. You are now setup to operate from your workstation as an Ansible controller that will function as the automation orchestrator with sudo privelege on all inventory hosts. This will be an all powerful superuser account, so guard its private key and be mindful of where you put it. This would be a good time to take *Day 0* snapshots of the virtual machines, because if the systems get corrupted, you will have a known-good restoration point from which to start over. Otherwise, proceed with deploying the site model using the playbooks *_site_before_roles.yml* and/or *site.yml* or go freestyle and experiment with cli usage options like: --list-tags, --list-hosts, --list-tasks, --skip-tags, -l, -t, -u. The full list of options is available by typeing ' ansible-playbook --help'.
  - 'ansible-playbook site.yml'
14. Finally, *mirror* this project to your new dev playground GitHub repository, then get familiar with Git functions: status, diff, add, commit and push. These commands are critical for proper usage of the git protocol.
  - 'git push --mirror https://github.com/YOUR-USER/YOUR-REPOSITORY.git'
  - 'cd ..'
  - 'rm -rf ansible.git'
  - 'cd YOUR-REPOSITORY'
  - 'git status'
  - 'nano README' (make a change and save)
  - 'git diff README.md'
  - 'git add README.md'
  - 'git status'
  - 'git commit -m "update to readme file"'
  - 'git push origin main'


## ASSUMPTIONS:

It is assumed that the hosts in INVENTORY are running SSH server and accessible via SSH by root or a sudo user that you defined when the virtual machines were created. Also, it is assumed that DNS name resolution works to resolve the hostnames to IP addresses. If not, add each host resolution to the INVENTORY file like such 'docker ansible_host=192.168.0.130' 
