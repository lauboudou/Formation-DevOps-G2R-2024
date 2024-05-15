#DC-01_2

Rename-NetAdapter -Name ethernet -NewName Interne 
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.0.1 -PrefixLength 24 -DefaultGateway 10.144.0.254
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1
Install-WindowsFeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
Install-ADDSForest -DomainName form-it.lab -InstallDns:$true 

New-ADOrganizationalUnit -Name IT -Path "dc=form-it,dc=lab"
New-ADOrganizationalUnit -Name Vente -Path "dc=form-it,dc=lab" 
New-ADOrganizationalUnit -Name Direction -Path "dc=form-it,dc=lab" 
New-ADOrganizationalUnit -Name RH -Path "dc=form-it,dc=lab"

New-ADGroup -name Directeurs -Path "OU=Direction,DC=form-it,DC=lab" -GroupCategory Security -GroupScope Global
New-ADGroup -name Techniciens -Path "OU=IT,DC=form-it,DC=lab" -GroupCategory Security -GroupScope Global
New-ADGroup -name Ingenieurs -Path "OU=IT,DC=form-it,DC=lab" -GroupCategory Security -GroupScope Global
New-ADGroup -name Recruteurs -Path "OU=RH,DC=form-it,DC=lab" -GroupCategory Security -GroupScope Global
New-ADGroup -name Vendeurs -Path "OU=Vente,DC=form-it,DC=lab" -GroupCategory Security -GroupScope Global

