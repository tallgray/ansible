#!/bin/bash
set -e

echo "🔍 Linting and syntax checking..."
ansible-lint playbooks/site.yml
ansible-playbook --syntax-check -i inventories/dev/hosts.ini playbooks/site.yml

echo "🧪 Running base common setup..."
ansible-playbook -i inventories/dev/hosts.ini playbooks/site.yml

echo "☸️ Testing Kubernetes control plane setup..."
ansible-playbook -i inventories/dev/hosts.ini playbooks/configure-k8s-control-plane.yml

echo "☸️ Testing Kubernetes worker node setup..."
ansible-playbook -i inventories/dev/hosts.ini playbooks/configure-k8s-workers.yml \
  -e "kubeadm_join_command='sudo kubeadm join 10.220.0.20:6443 --token <your-token> --discovery-token-ca-cert-hash sha256:<your-hash>'"

echo "🐳 Deploying individual container stacks with tags..."

for tag in grafana elk vault jenkins gitlab devops; do
  echo "➡️ Testing deployment of role: $tag"
  ansible-playbook -i inventories/dev/hosts.ini playbooks/deploy-containers.yml --tags "$tag"
done

echo "✅ All tests completed successfully."
