Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer –Source "https://jenkinsaspass.blob.core.windows.net/software/jenkins.msi" -Destination "D:\"
Start-Sleep 60
Start-Process D:\jenkins.msi /qn 



