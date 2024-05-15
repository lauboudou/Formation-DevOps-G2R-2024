#creation de disque de différenciation à partir d'un Parent et création des VM DC-01, Hote-01, Hote-02 et Hote-03

New-VHD -Path C:\Hyper-V\Hote-01\Hote-01.vhdx -ParentPath c:\hyper-v\master\master.vhdx -Differencing
New-VHD -Path C:\Hyper-V\Hote-02\Hote-02.vhdx -ParentPath c:\hyper-v\master\master.vhdx -Differencing
New-VHD -Path C:\Hyper-V\Hote-03\Hote-03.vhdx -ParentPath c:\hyper-v\master\master.vhdx -Differencing
New-VHD -Path C:\Hyper-V\DC-01\DC-01.vhdx -ParentPath c:\hyper-v\master\master.vhdx -Differencing

#creation de VMs à partir de disque de differenciation 
New-VM -Name Hote-03 -MemoryStartupBytes 6GB -Path c:\hyper-v\Hote-03 -VHDPath C:\Hyper-V\Hote-03\Hote-03.vhdx -Generation 2 -SwitchName interne
New-VM -Name Hote-02 -MemoryStartupBytes 6GB -Path c:\hyper-v\Hote-02 -VHDPath C:\Hyper-V\Hote-02\Hote-02.vhdx -Generation 2 -SwitchName interne
New-VM -Name Hote-01 -MemoryStartupBytes 6GB -Path c:\hyper-v\Hote-01 -VHDPath C:\Hyper-V\Hote-01\Hote-01.vhdx -Generation 2 -SwitchName interne
New-VM -Name DC-01 -MemoryStartupBytes 6GB -Path c:\hyper-v\DC-01 -VHDPath C:\Hyper-V\DC-01\DC-01.vhdx -Generation 2 -SwitchName interne
Enable-VMIntegrationService -VMName DC-01, Hote-01, hote-02, hote-03 -Name Interface*
Set-VM -Name DC-01, Hote-01, hote-02, hote-03 -ProcessorCount 2
Set-VM -Name DC-01, Hote-01, hote-02, hote-03 -CheckpointType Disabled
