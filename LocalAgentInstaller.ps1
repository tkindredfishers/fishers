$tmp = "$env:TEMP\CloudiwayAgent.msi"
$cdw = "$env:USERPROFILE\.cloudiway\agent"

Invoke-WebRequest "https://cloudiwaycdn.z13.web.core.windows.net/master/CloudiwayAgent.msi" -OutFile $tmp

Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $tmp TARGETDIR=$cdw /qn COMPANYKEY=e446415e-74f5-42cf-9779-0e05e8846043;https://fisherstechapi.cloudiway.com" -Wait

Start-Process -FilePath "CloudiwayAgent.exe" -WorkingDirectory "$cdw" -Verb runAs