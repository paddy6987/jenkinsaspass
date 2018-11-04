Write-Host "Initiating PaaS  Deployment...............

" -ForegroundColor Green
$Software = Read-Host -Prompt "Enter Software Name to have custom VM(Separated with comma):
                                Jenkins
                                Artifactory
                                Sonarqube 
                                "

$mystring = New-Object 'System.Collections.Generic.List[String]'
$UserInputList = $Software.Split(",")| ForEach {
  $mystring.Add($_)
}

$RG = "loadbalancer"
#vm creation

New-AzureRmResourceGroup -Name loadbalancer -Location "centralus"
New-AzureRmResourceGroupDeployment -Name loadbalancer -ResourceGroupName $RG `
 -TemplateUri "https://raw.githubusercontent.com/paddy6987/jenkinsaspass/master/final.json" `
 -TemplateParameterUri "https://raw.githubusercontent.com/paddy6987/jenkinsaspass/master/final.parameters.json"
 
 start-sleep 380

$varloc = (Get-AzureRmResourceGroup -Name $RG).Location

$vm =(Get-AzureRmResource  -ResourceGroupName $RG  -ResourceType Microsoft.Compute/virtualMachines).Name[1]



#Loop for VM Extension 

For ($i=0; $i -le $mystring.Count; $i++) {
   
  switch ( $mystring[$i])
 {

  Artifactory {  Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name "myCustom123" `
               -FileUri "https://raw.githubusercontent.com/paddy6987/jenkinsaspass/master/installartifactory.ps1" `
               -Run "installartifactory.ps1" `
               -Location $varloc 
               Write-Host "Login from browser with port 8081" -ForegroundColor Green 
               Write-Host "Login Username and PAssword is admin" -ForegroundColor Green 
               start-sleep 220 
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name myCustom123   -Force
               }
                              
  Jenkins     {  Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name "myCustom123" `
               -FileUri "https://raw.githubusercontent.com/paddy6987/jenkinsaspass/master/install.ps1" `
               -Run "install.ps1" `
               -Location $varloc
               Write-Host "Login from browser with port 8080" -ForegroundColor Green 
               Write-Host "Login Username and PAssword will be sent to user" -ForegroundColor Green
               start-sleep 80 
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name myCustom123   -Force
                               }
  Sonarqube   {  Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name "myCustom123" `
               -FileUri "https://raw.githubusercontent.com/paddy6987/jenkinsaspass/master/installsonarqube.ps1" `
               -Run "installsonarqube.ps1" `
               -Location $varloc 
               Write-Host "Login from browser with port 9000" -ForegroundColor Green 
               Write-Host "Login Username and PAssword is admin" -ForegroundColor Green
               start-sleep 240 
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name myCustom123   -Force
                               }
 } 
 }