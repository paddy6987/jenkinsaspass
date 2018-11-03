Get-Date | Out-File D:\textzz.txt
Start-BitsTransfer –Source 'https://jenkinsaspass.blob.core.windows.net/software/artifactory-oss-6.5.2.zip' -Destination 'D:\'
