#Sur la machine physique
#Sur Power shell de la machine physique taper
#Installer les windowsFeature sur Hote-01 et Hote-02

$cred = Get-Credential form-it\admin
Invoke-Command -VMName Hote-01, Hote-02 -ScriptBlock { install-windowsfeature Multipath-io -includeAllsubFeature -includeManagementTools } -credential $cred


#Pour rendre possible la création des VM dans Hote-01 et Hote-02
#Arrêter les Hote-01 et Hote-02

Stop-VM -Name Hote-01, Hote-02

#Lancer cette commande pour autoriser la virtualisation embriquée
Set-VMProcessor -ExposeVirtualizationExtensions:$true -VMName Hote-01, Hote-02

#Activer le spoofing (extention d’adresse mac sur les sous vm de hote 01 et 02)
Get-VMNetworkAdapter -VMName Hote-01, Hote-02 | set-VMNetworkAdapter -MacAddressSpoofing on

#Redémarrer les Hote-01, Hote-02
Start-VM -VMName Hote-01, Hote-02

#lancer cette commande pour activer le service MSISCSI sur les hote-01 et hote-02. L’authentification est refaite pour éviter des erreurs.
$cred = Get-Credential form-it\admin
Invoke-Command -VMName Hote-01, Hote-02 -ScriptBlock { Get-Service MSISCSI | Start-Service; Set-Service -Name MSISCSI -StartupType Automatic } -credential $cred


# Créer les disk 01 02 03 et 04
$cred = Get-Credential form-it\admin
Invoke-Command -VMName Hote-01, Hote-02 -ScriptBlock { install-windowsfeature Hyper-v -includeAllsubFeature -includeManagementTools -restart } -credential $cred


# Regrouper les Hote-01 et Hote-02
Invoke-Command -VMName Hote-01, Hote-02 -ScriptBlock { install-windowsfeature -Name Failover-CLustering -includeAllsubFeature -includeManagementTools } -credential $cred

# Vérifier les Hote-01 ou Hote-02 qu’ils sont compatibles 
Test-Cluster -Node hote-01.form-it.lab, hote-02.form-it.lab 

