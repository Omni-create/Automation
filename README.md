# Automation
 Keuzedeel AD jaar 1

 STRUCTUUR:
 Automation/
├── inventory/
│   └── inventory.ini          # Statisch inventory bestand
│
├── playbooks/
│   ├── setup.sh   
│   ├── setup.yml            
│   └── setup_software.yml     
│
├── group_vars/				   # OPTIONEEL:
│   └── all.yml                # Veel voorkomende variabelen definiëren.
│
├── host_vars/				   # OPTIONEEL:
│   ├── vm-front-end.yml       # Front-end VM specific vars
│   ├── vm-back-end.yml        # Back-end VM specific vars
│   └── vm-stepping-stone.yml  # Stepping stone VM specific vars
└── ansible.cfg                # Ansible configuration
 
 
 TO CONSIDER:
- Gebruik SSH Keys inpv wachtwoorden
- Bewaar belangrijke informatie binnen Ansible Vault
- Stricthostkeychecking aan zetten i.v.m. MiTM-Attacks

 TO FIX:
 - setup_software.yml zorgen dat het Prometheus & Grafana niet alleen download maar ook installeert en configureert.
 - setup_software.yml native maken (zorgen dat het op alle soorten systemen uitgevoerd kan worden)
 - setup.yml poorten openen binnen de NSGs.
 - delete.yml Binnen de Azure portal staan "public ipadresses" die om de 1 of de andere reden niet verwijderd willen worden.
 - Bij het runnen van de setup worden alle vm's ineens in de 1e subnet geplaatst (front-end)
 
 
FIXED:
 - setup.sh interface maken met keuzes en de mogelijkheid geven credentials in de cli toe te voegen
  
OPMERKINGEN:
 - "retry_files_enabled = False" --> "Insanity: doing the same thing over and over again and expecting different results." - Albert Einstein
  (Wanneer is dat wel nuttig?:
  Bij grote inventories waar je niet alle hosts handmatig wilt herhalen.
  Bij tijdelijke fouten zoals netwerkvertraging.)
  Niet persé van toepassing bij deze casus :) ~ Osa
  