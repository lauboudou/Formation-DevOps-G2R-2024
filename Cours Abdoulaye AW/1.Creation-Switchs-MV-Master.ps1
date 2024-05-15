#activer hyper-v

#enabled-WindowsOptionalFeature -Online -FeatureName Microsoft-hyper-v-all

#verifier les cartes réseaux 
#Get-NetAdapter

#création d'un switch externe
New-VMSwitch -name Externe -NetAdapterName WI-FI

#création de switch privé
New-VMSwitch -name MPIO1 -SwitchType Private
New-VMSwitch -name MPIO2 -SwitchType Private
New-VMSwitch -name Pulsation -SwitchType Private  

#création de switch interne 
New-VMSwitch -name Interne -SwitchType Internal


#Création d'une VM ( Master)

New-VM -Name Master -MemoryStartupBytes 6GB -Path c:\hyper-v\Master -NewVHDPath C:\Hyper-V\Master\Master.vhdx -Generation 2 -SwitchName interne -NewVHDSizeBytes 200GB

#Activer les services d'invité (tools)
Enable-VMIntegrationService -VMName Master -Name Interface*

#modifier le nombre de CPU
Set-VM -Name Master -ProcessorCount 2

#desactiver le point de control ( désactiver le snapshot)
Set-VM -Name Master -CheckpointType Disabled
 

Add-VMDvdDrive -VMName Master -Path C:\Users\admin\Downloads\Windows-Server-2022-EVAL_x64FRE_fr-fr.iso
$vmdvd = Get-VMDvdDrive -VMName Master
Set-VMFirmware -VMName Master -FirstBootDevice $vmdvd


#Procedure pour le sysprep (enlever les parametres specifique à une machine en vue de le deployer ou de le cloner )
#cd C:\windows\system32\sysprep
#.\sysprep.exe /generalize /oobe /shutdown

#ou 
#C:\windows\system32\sysprep\sysprep.exe /generalize /oobe /shutdown


#mettre disque de Master en lecture seul (Read Only)
