#HOTE-01_2

Add-Computer -DomaineName form-it.lab -Credential admin@form-it.lab

#se connecter avec Admin ( l'administrateur du domaine)

Rename-NetAdapter -Name "ethernet 2"  -NewName MPIO1
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.1.10 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1

Rename-NetAdapter -Name "ethernet 3"  -NewName MPIO2
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.2.10 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1

Rename-NetAdapter -Name "ethernet 4"  -NewName Pulsation
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.3.10 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1


<# Aller sur Hote-01 ou Hote-02 à faire que sur une machine,Interface Graphique, Gestionnaire de serveur, iSCS
Dans les propriétés renseigné dans Paramètres avancés, Général
Adaptateur Local : Initiateur Microsoft iCSI
IP de l’initiateur : 10.144.0.10
IP du portal cible: 10.144.0.30/3260 #>
