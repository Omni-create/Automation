# Automation
 Keuzedeel AD jaar 1

 setup.sh 
 Download alle benodigde software en logt in de azure omgeving.

 setup.yml
 Zet de omgeving op, 1 vnet, 3 subnets, 3 NSGs, 3 VM's.

 setup_software.yml
 Installeert software op de servers

 delete.yml
 Delete de omgeving
 
 
 TO FIX:
 - setup_software.yml zorgen dat het Prometheus & Grafana niet alleen download maar ook installeert en configureert.
 - setup_software.yml native maken (zorgen dat het op alle soorten systemen uitgevoerd kan worden)
 - setup.yml poorten openen binnen de NSGs.
 
 FIXED:
  - setup.sh interface maken met keuzes en de mogelijkheid geven credentials in de cli toe te voegen