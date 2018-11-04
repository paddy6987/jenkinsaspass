$url = "https://jenkinsaspass.blob.core.windows.net/software/jenkins.msi"
$drive = "D:\"
Start-BitsTransfer –Source $url -Destination $drive
Start-Sleep 60
 Start-Process D:\jenkins.msi /qn 



