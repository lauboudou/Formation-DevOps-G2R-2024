# Hote-02
# Configuration Switchs sur Hote-01

Rename-NetAdapter -name "ethernet" -NewName MPIO1
New-NetIPAddress -InterfaceAlias MPIO1 -IPAddress 10.144.1.20 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias MPIO1 -ServerAddresses 10.144.0.1

Rename-NetAdapter -name "ethernet 2" -NewName MPIO2
New-NetIPAddress -InterfaceAlias MPIO2 -IPAddress 10.144.2.20 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias MPIO2 -ServerAddresses 10.144.0.1

Rename-NetAdapter -name "ethernet 3" -NewName PULSATION
New-NetIPAddress -InterfaceAlias PULSATION -IPAddress 10.144.3.20 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias PULSATION -ServerAddresses 10.144.0.1



