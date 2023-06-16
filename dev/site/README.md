# ansible
End-to-end automation to configure hosts, containers, and deploy software.

## Create ssh key pair for your username and define a custom file name
ssh-keygen -t ed25519 -C "<USERNAME1>" -f id_<USERNAME1>

## Create ssh key pair for an automation role and define a custom file name
ssh-keygen -t ed25519 -C "<USERNAME2>" -f id_<USERNAME2>

## Display the key pairs and the public keys
ls -la ~/.ssh
cat ~/.ssh/id_*.pub

## Create a github account and repository, add public SSH key to settings, and test access
# https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account
# https://docs.github.com/en/get-started/quickstart/create-a-repo (Select Initialize this repository with a README.)
# https://docs.github.com/en/github-ae@latest/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
ssh -T git@github.com
# Hi tallgray! You've successfully authenticated, but GitHub does not provide shell access.
# If authentication is denied, refer to this troubleshooting guide
# https://docs.github.com/en/authentication/troubleshooting-ssh/error-permission-denied-publickey


## Clone the repository to your local machine. A sub-folder will be created matching the name of your repository and contain the README.md file.
git clone git@github.com:tallgray/ansible.git

## Change directory to the repository subfolder
cd ansible
ls -la

## Get familiar with status, diff, add, commit and push commands used with git protocol
nano README.md

## Add a welcome statement to the file
git status
git diff README.md
git add README.md
git status
git commit -m "updated readme file"
git push origin main

## Copy public SSH key to a remote server authorized_keys file
ssh-copy-id -i ~/.ssh/id_<USERNAME1>.pub <USERNAME1>@<REMOTE_IP>

