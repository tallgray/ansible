# ansible
End-to-end automation to configure systems, deploy software, and orchestrate advanced workflows!

Start with the 'userSetupSudoers.yaml':
ansible-playbook -i inventory userSetupSuder.yaml -k -l "ubuntu_servers,ubuntu_desktops" -e="user=tallgray1"

This will do the following:
	-Setup passwordless sudo
	-Create a new regular user with sudo privileges
	-Set authorized key for remote user
	-Disable password authentication for root
