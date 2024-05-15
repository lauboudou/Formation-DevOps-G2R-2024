#Hote-03
Rename-NetAdapter -Name ethernet -NewName Interne 
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.0.30 -PrefixLength 24 -DefaultGateway 10.144.0.254
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1
Rename-Computer Hote-03
Rename-LocalUser administrateur -NewName Admin

Add-Computer -DomainName form-it.lab -Credential admin@form-it.lab -Restart

#Restart-Computer 

