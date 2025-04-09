# Ansible Infrastructure Automation for tallgray.net

This project manages configuration and automation for a home lab and hybrid infrastructure, including:

- Proxmox hypervisors
- Docker hosts and containers
- Kubernetes clusters
- pfSense firewall
- Windows AD and DNS
- TrueNAS file storage

## 📁 Project Structure

- \`inventories/\` – Separate inventories for \`dev\` and \`prod\`
- \`roles/\` – Modular Ansible roles
- \`playbooks/\` – Playbooks to apply roles
- \`.gitlab-ci.yml\` – GitLab CI/CD automation
- \`.ansible-lint\` – Ansible linting config

## 🚀 Usage

### Sites

Run against dev:

\`\`\`bash
ansible-playbook -i inventories/dev/hosts.ini playbooks/site.yml
\`\`\`

Run against prod:

\`\`\`bash
ansible-playbook -i inventories/prod/hosts.ini playbooks/site.yml
\`\`\`

### K8S Control Plane
```bash
ansible-playbook -i inventories/prod/hosts.ini playbooks/configure-k8s-control-plane.yml
```
### K8S Workers
```bash
ansible-playbook -i inventories/prod/hosts.ini playbooks/configure-k8s-workers.yml -e "kubeadm_join_command='sudo kubeadm join <ip>:6443 --token <to>
```

## 🛠 Setup Notes

- Uses key \`~/.ssh/id_tallgray1\`
- AWS config in \`~/.aws/config\`
- Git user: Glenn Gray (\`tallgray1@gmail.com\`)
