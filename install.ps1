Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer –Source "https://jenkinsaspass.blob.core.windows.net/software/jenkins.msi" -Destination D:\
cd D:\
Start-Process jenkins.msi /qn 
Start-Sleep 60
echo "Admin123" | out-file  C:\Program Files (x86)\Jenkins\secrets\initialAdminPassword

