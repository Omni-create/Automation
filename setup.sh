
#echo "Adding Azure credentials into .profile"

#echo "export AZURE_SUBSCRIPTION_ID=*" >> ~/.profile
#echo "export AZURE_CLIENT_ID=*" >> ~/.profile
#echo "export AZURE_SECRET=*" >> ~/.profile
#echo "export AZURE_TENANT=*" >> ~/.profile

#echo ".profile refreshen...."
#source ~/.profile

#echo "Installeren van ansible, pip3 en extra's...."
#sudo apt update -y
#sudo apt install ansible -y
#sudo apt install python3-pip -y 
#ansible-galaxy collection install azure.azcollection --force
#pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt --break-system-packages
#PATH=$PATH:~/.local/bin/
#export
#curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#pip install azure-cli-core --break-system-packages
#pip install msrest azure-mgmt-compute azure-mgmt-network azure-mgmt-resource --break-system-packages
#ansible-galaxy collection install azure.azcollection

#clear
#echo "run 'az login --use-device-code' en verifieër jezelf via je browser middels de code."
#echo "run ansible-playbook jouw_playbook.yml"


#!/bin/bash

clear
echo " Azure & Ansible Setup Tool"

while true; do
  echo ""
  echo "Maak een keuze:"
  echo "1) Credentials toevoegen"
  echo "2) Configuratie uitvoeren voor de host (installeren van Ansible etc..)"
  echo "3) Azure omgeving opzetten (setup.yml)"
  echo "4) Software installeren in Azure omgeving (setup_software.yml)"
  echo "5) Azure omgeving verwijderen (delete.yml)"
  echo "6) Afsluiten\n"
  read -p "Voer je keuze in [1-6]: " keuze

  case $keuze in
	1)
	read -p "Voer je Azure Subscription ID in: " AZURE_SUBSCRIPTION_ID
	read -p "Voer je Azure Client ID in: " AZURE_CLIENT_ID
	read -p "Voer je Azure Secret in: " AZURE_SECRET
	read -p "Voer je Azure Tenant ID in: " AZURE_TENANT
	echo "Azure credentials binnen ~/.profile zetten.."
	{
	echo "export AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID"
	echo "export AZURE_CLIENT_ID=$AZURE_CLIENT_ID"
	echo "export AZURE_SECRET=$AZURE_SECRET"
	echo "export AZURE_TENANT=$AZURE_TENANT"
	} >> ~/.profile
	source ~/.profile
    2)
      echo "Start volledige setup..."
      sudo apt update -y
      sudo apt install -y ansible python3-pip
      ansible-galaxy collection install azure.azcollection --force
      pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt --break-system-packages
      export PATH=$PATH:~/.local/bin
      curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
      pip3 install azure-cli-core --break-system-packages
      az login --use-device-code
      echo "Setup voltooid."
      ;;
    3)
      echo "Draait playbook: setup.yml"
      ansible-playbook /playbooks/setup.yml
      ;;
    4)
      echo "Draait playbook: setup_software.yml"
      ansible-playbook /playbooks/setup_software.yml
      ;;
    5)
      echo "Draait playbook: delete.yml (verwijdert omgeving)"
      ansible-playbook /playbooks/delete.yml
      ;;
    6)
      echo "Tot de volgende keer :)!"
      exit 0
      ;;
    *)
      echo "Ongeldige keuze, probeer het opnieuw."
      ;;
  esac
done
