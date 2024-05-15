#HOTE-02_2

Add-Computer -DomaineName form-it.lab -Credential admin@form-it.lab
se connecter avec Admin ( l'administrateur du domaine)
Rename-NetAdapter -Name "ethernet 2" -NewName MPIO1
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.1.20 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1
Rename-NetAdapter -Name "ethernet 3" -NewName MPIO2
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.2.20 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1
Rename-NetAdapter -Name "ethernet 4" -NewName Pulsation
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.3.20 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1

