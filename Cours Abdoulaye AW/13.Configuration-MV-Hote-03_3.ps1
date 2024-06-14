
# Sur Hote-03
Rename-NetAdapter -name "ethernet" -NewName MPIO1
New-NetIPAddress -InterfaceAlias MPIO1 -IPAddress 10.144.1.30 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias MPIO1 -ServerAddresses 10.144.0.1

Rename-NetAdapter -name "ethernet 2" -NewName MPIO2
New-NetIPAddress -InterfaceAlias MPIO2 -IPAddress 10.144.2.30 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias MPIO2 -ServerAddresses 10.144.0.1

# Aller sur le fichier de creation de 9 VHD sur Hote-03 et revenir ici

# Les commandes pour mettre les disques dans pool de stockage
$PhysicalDisks = (Get-PhysicalDisk -CanPool $True)
New-StoragePool -FriendlyName storagepool01 -StorageSubsystemFriendlyName "Windows Storage*" -PhysicalDisks $PhysicalDisks


# Créer un disque Virtuel à partir du pool de stockage créer précédemment sur HOTE-03
New-VirtualDisk -StoragePoolFriendlyName storagepool01 -FriendlyName VirtualDisk1 -ResiliencySettingName Mirror -Size 128TB -ProvisioningType Thin -NumberOfDataCopies 3


# Préparer une partition de size 64TB, lettre E
Get-Disk -Number 10 | Initialize-Disk -PassThru | New-Partition -DriveLetter E -Size 64TB | Format-Volume -FileSystem ReFS

# Permettre à Hote-01 et Hote-02 : de communiquer avec Hote-03
# Installer le windows Feature de iscs et iscs VSS VDS 
Install-WindowsFeature -name iscsitarget-vss-vds, fs-iscsitarget-server -IncludeAllSubFeature -IncludeManagementTools 

#Créer des disques ISCS sur la lacteur E
New-IscsiVirtualDisk -Path "E:\iscs\disk1.vhdx" -Size 15TB
New-IscsiVirtualDisk -Path "E:\iscs\disk2.vhdx" -Size 15TB
New-IscsiVirtualDisk -Path "E:\iscs\disk3.vhdx" -Size 15TB
New-IscsiVirtualDisk -Path "E:\iscs\disk4.vhdx" -Size 100GB

New-IscsiServerTarget -TargetName target1 -InitiatorIds 'iqn:iqn:1991-05.com.microsoft:hote-01.form-it.lab', 'iqn:iqn:1991-05.com.microsoft:hote-02.form-it.lab' 

# Faire le mapping entre target1 et les 4 disques
Add-IscsiVirtualDiskTargetMapping -TargetName target1 -Path 'E:\iscs\Disk1.vhdx'

Add-IscsiVirtualDiskTargetMapping -TargetName target1 -Path 'E:\iscs\Disk2.vhdx'

Add-IscsiVirtualDiskTargetMapping -TargetName target1 -Path 'E:\iscs\Disk3.vhdx'

Add-IscsiVirtualDiskTargetMapping -TargetName target1 -Path 'E:\iscs\Disk4.vhdx'


