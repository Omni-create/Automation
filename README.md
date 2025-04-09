# Automation
 Keuzedeel AD jaar 1

 STRUCTUUR:<br />
 Automation/ <br />
├── inventory/ <br />
│   └── inventory.ini          # Statisch inventory bestand <br />
│ <br />
├── playbooks/ <br />
│   ├── setup.sh   <br />
│   ├── setup.yml            <br />
│   └── setup_software.yml     <br />
│
├── group_vars/				   # OPTIONEEL:<br />
│   └── all.yml                # Veel voorkomende variabelen definiëren.<br />
│<br />
├── host_vars/				   # OPTIONEEL:<br />
│   ├── vm-front-end.yml       # Front-end VM specific vars<br />
│   ├── vm-back-end.yml        # Back-end VM specific vars<br />
│   └── vm-stepping-stone.yml  # Stepping stone VM specific vars<br />
└── ansible.cfg                # Ansible configuration<br />
 
 
 TO CONSIDER:
- Gebruik SSH Keys inpv wachtwoorden
- Bewaar belangrijke informatie binnen Ansible Vault
- Stricthostkeychecking aan zetten i.v.m. MiTM-Attacks --> Besproken met Marcel, de nadruk word in dit keuzedeel op Automation gezet dus dit zetten we niet aan.

 TO FIX:
 - setup_software.yml zorgen dat het Prometheus & Grafana niet alleen download maar ook installeert en configureert.
 - setup_software.yml native maken (zorgen dat het op alle soorten systemen uitgevoerd kan worden)
 - setup.yml poorten openen binnen de NSGs.
 - delete.yml Binnen de Azure portal staan "public ipadresses" die om de 1 of de andere reden niet verwijderd willen worden.
 
 
 
FIXED:
 - setup.sh interface maken met keuzes en de mogelijkheid geven credentials in de cli toe te voegen
 - Bij het runnen van de setup worden alle vm's ineens in de 1e subnet geplaatst (front-end)
 - .gitignore file ff aanmaken
 
OPMERKINGEN:
 - "retry_files_enabled = False" --> "Insanity: doing the same thing over and over again and expecting different results." - Albert Einstein
  (Wanneer is dat wel nuttig?:
  Bij grote inventories waar je niet alle hosts handmatig wilt herhalen.
  Bij tijdelijke fouten zoals netwerkvertraging.)
  Niet persé van toepassing bij deze casus :) ~ Osa
  