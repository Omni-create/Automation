
echo "Adding Azure credentials into .profile"

echo "export AZURE_SUBSCRIPTION_ID=*" >> ~/.profile
echo "export AZURE_CLIENT_ID=*" >> ~/.profile
echo "export AZURE_SECRET=*" >> ~/.profile
echo "export AZURE_TENANT=*" >> ~/.profile

echo ".profile refreshen...."
source ~/.profile

echo "Installeren van ansible, pip3 en extra's...."
sudo apt update -y
sudo apt install ansible -y
sudo apt install python3-pip -y 
ansible-galaxy collection install azure.azcollection --force
pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt --break-system-packages
PATH=$PATH:~/.local/bin/
export
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
pip install azure-cli-core --break-system-packages
pip install msrest azure-mgmt-compute azure-mgmt-network azure-mgmt-resource --break-system-packages
ansible-galaxy collection install azure.azcollection

clear
echo "run 'az login --use-device-code' en verifieër jezelf via je browser middels de code."
echo "run ansible-playbook jouw_playbook.yml"
