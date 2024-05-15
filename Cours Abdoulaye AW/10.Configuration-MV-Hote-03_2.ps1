#Hote-03_02

Add-Computer -DomaineName form-it.lab -Credential admin@form-it.lab
#se connecter avec Admin ( l'administrateur du domaine)

Rename-NetAdapter -Name "ethernet 2"  -NewName MPIO1
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.1.30 -PrefixLength 24 éa"
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1
Rename-NetAdapter -Name "ethernet 3"  -NewName MPIO2
New-NetIPAddress -InterfaceAlias Interne -IPAddress 10.144.2.30 -PrefixLength 24 
Set-DnsClientServerAddress -InterfaceAlias interne -ServerAddresses 10.144.0.1

#creation de 9 disques de 4TB dans le repertoire hyper-v\hote-03
New-VHD -Path C:\Hyper-V\Hote-03\DD1.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD2.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD3.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD4.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD5.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD6.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD7.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD8.vhdx -SizeBytes 4TB -Dynamic
New-VHD -Path C:\Hyper-V\Hote-03\DD9.vhdx -SizeBytes 4TB -Dynamic

#ajout de disque dans la vm

Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD1.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD2.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD3.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD4.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD5.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD6.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD7.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD8.vhdx
Add-VMHardDiskDrive -VMName Hote-03 -Path C:\Hyper-V\Hote-03\DD9.vhdx


$physicaldisk = Get-PhysicalDisk -canpool $true
New-StoragePool -FriendlyName "StoragePool01" -StorageSubSystemFriendlyName "windows storage*" -PhysicalDisks $physicaldisk
New-VirtualDisk -StoragePoolFriendlyName storagepool1 -FriendlyName VirtualDisk1 -ResiliencySettingName Mirror -Size 128TB -ProvisioningType Thin -NumberOfDataCopies 3

Get-Disk
Get-Disk -Number 10 | Initialize-Disk -PassThru | New-Partition -DriveLetter E -Size 64TB | Format-Volume -FileSystem ReFS

Install-WindowsFeature -Name iscsitarget-vss-vds, fs-iscsitarget-server -IncludeAllSubFeature -IncludeManagementTools

New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk1.vhdx' -SizeBytes 15TB
New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk2.vhdx' -SizeBytes 15TB
New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk3.vhdx' -SizeBytes 15TB
New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk4.vhdx' -SizeBytes 100GB


New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk1.vhdx' -SizeBytes 15TB

New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk2.vhdx' -SizeBytes 15TB

New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk3.vhdx' -SizeBytes 15TB

New-IscsiVirtualDisk -Path 'E:\IscsiVirtualDisk\Disk4.vhdx' -SizeBytes 100GB
 
New-IscsiServerTarget -TargetName target1 -InitiatorIds 'iqn:iqn.1991-05.com.microsoft:hote-01.form-it.lab','iqn:iqn.1991-05.com.microsoft:hote-02.form-it.lab'
 


$cred = Get-Credential form-it\admin

Invoke-Command -VMName Hote-01,Hote-02 -ScriptBlock { install-windowsfeature Multipath-IO -IncludeAllSubFeature -IncludeManagementTools } -credential $cred

Set-VMProcessor -ExposeVirtualizationExtensions:$true -VMName Hote-01,hote-02

Get-VMNetworkAdapter -VMName Hote-01,hote-02 | Set-VMNetworkAdapter -MacAddressSpoofing on

Invoke-Command -VMName Hote-02 -ScriptBlock { enable-msdsmautomaticclaim -BusType iscsi ; enable-msdsmautomaticclaim -BusType SAS } -credential $cred

Invoke-Command -VMName Hote-01,Hote-02 -ScriptBlock { install-windowsfeature Hyper-v -IncludeAllSubFeature -IncludeManagementTools -restart } -credential $cred

Invoke-Command -VMName Hote-01,Hote-02 -ScriptBlock { install-windowsfeature -Name Failover-Clustering -IncludeAllSubFeature -IncludeManagementTools  } -credential $cred

Test-Cluster -Node Hote-01.form-it.lab,hote-02.form-it.lab

New-Cluster -Node Hote-01.form-it.lab,Hote-02.form-it.lab -name cluster-Failover -StaticAddress 10.144.0.144

Invoke-Command -VMName Hote-01,Hote-02 -ScriptBlock { New-VMSwitch -name Externe -NetAdapterName Interne} -credential $cred

Invoke-Command -VMName Hote-01 -ScriptBlock {Set-VMHost -VirtualHardDiskPath c:\clusterstorage\volume1-hote01\Hyper-V -VirtualMachinePath c:\clusterstorage\volume1-hote01\Hyper-V} -credential $cred

Invoke-Command -VMName Hote-02 -ScriptBlock {New-VM -MemoryStartupBytes 2GB -Generation 2 -Name SRV-WEB2 -Path c:\clusterstorage\volume3-hote02\Hyper-V\ -NewVHDPath c:\clusterstorage\volume3-hote02\Hyper-V\SRV-WEB2\srv-web2.vhdx -NewVHDSizeBytes 100GB -SwitchName Externe } -credential $cred

Invoke-Command -VMName Hote-01 -ScriptBlock {New-VM -MemoryStartupBytes 2GB -Generation 2 -Name SRV-WEB1 -Path c:\clusterstorage\volume1-hote01\Hyper-V\ -NewVHDPath c:\clusterstorage\volume1-hote01\Hyper-V\SRV-WEB2\srv-web1.vhdx -NewVHDSizeBytes 100GB -SwitchName Externe } -credential $cred

