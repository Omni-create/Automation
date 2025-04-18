#!/bin/bash

LOCAL_PLAYBOOK_PATH="./playbooks/setup_software.yml"
LOCAL_INVENTORY_PATH="./inventory/inventory.ini"
REMOTE_TARGET_DIR="~/ansible"
STEPPING_STONE_USER=""
STEPPING_STONE_IP=""
STEPPING_STONE_PASSWORD=""

read -p "Voer de username van je steppingstone server in: " STEPPING_STONE_USER
read -p "Voer het publieke ip-adress in van je steppingstone server: " STEPPING_STONE_IP
read -sp "Voer je wachtwoord in voor je steppingstone server: " STEPPING_STONE_PASSWORD

echo "Installeren van sshpass (indien niet geïnstalleerd)..."
sudo apt-get update
sudo apt-get install -y sshpass
ssh-keyscan "$STEPPING_STONE_IP" >> ~/.ssh/known_hosts


echo "Copying $LOCAL_PLAYBOOK_PATH to $STEPPING_STONE_USER@$STEPPING_STONE_IP:$REMOTE_TARGET_DIR"
sshpass -p "$STEPPING_STONE_PASSWORD" ssh -o StrictHostKeyChecking=no "$STEPPING_STONE_USER@$STEPPING_STONE_IP" "mkdir -p $REMOTE_TARGET_DIR"

sshpass -p "$STEPPING_STONE_PASSWORD" scp -o StrictHostKeyChecking=no "$LOCAL_PLAYBOOK_PATH" "$STEPPING_STONE_USER@$STEPPING_STONE_IP:$REMOTE_TARGET_DIR/"
sshpass -p "$STEPPING_STONE_PASSWORD" scp -o StrictHostKeyChecking=no "$LOCAL_INVENTORY_PATH" "$STEPPING_STONE_USER@$STEPPING_STONE_IP:$REMOTE_TARGET_DIR/"

if [ $? -eq 0 ]; then
    echo "Playbook succesvol gekopieerd naar stepping-stone server!"
else
    echo "Fout bij het kopiëren van het playbook."
    exit 1
fi

echo "Controleren of Ansible is geïnstalleerd op de stepping-stone server..."

sshpass -p "$STEPPING_STONE_PASSWORD" ssh -o StrictHostKeyChecking=no "$STEPPING_STONE_USER@$STEPPING_STONE_IP" << EOF
  if ! command -v ansible &> /dev/null; then
    echo "Ansible niet gevonden. Ansible wordt geïnstalleerd..."
    sudo apt-get update && sudo apt-get install -y ansible
  else
    echo "Ansible is al geïnstalleerd."
  fi

  if ! command -v sshpass &> /dev/null; then
    echo "sshpass niet gevonden. sshpass wordt geïnstalleerd..."
    sudo apt-get update && sudo apt-get install -y sshpass
  else
    echo "sshpass is al geïnstalleerd."
  fi
EOF

echo "Het Ansible playbook wordt uitgevoerd op de stepping-stone server..."

sshpass -p "$STEPPING_STONE_PASSWORD" ssh -o StrictHostKeyChecking=no "$STEPPING_STONE_USER@$STEPPING_STONE_IP" << EOF
  cd $REMOTE_TARGET_DIR
  ansible-playbook -i ./inventory.ini setup_software.yml
  exit
EOF

if [ $? -eq 0 ]; then
    echo "Het Ansible playbook is succesvol uitgevoerd op de stepping-stone server!"
else
    echo "Het uitvoeren van het Ansible playbook is mislukt."
    exit 1
fi

echo "Script voltooid!"
