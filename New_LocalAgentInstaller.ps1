Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Define temporary file path
$tmp = "$env:TEMP\CloudiwayAgent.msi"

# Get the current user (OFFICE\first.last)
$usr = $(Get-CimInstance Win32_ComputerSystem | Select-Object username).username

# Remove OFFICE prefix for user profile path
$username = $usr -replace '.*\\', '' -replace ' ', '.'

# Define Cloudiway Agent working directory
$cdw = "C:\Users\$($username)\.cloudiway\agent"

Invoke-WebRequest 'https://cloudiwaycdn.z13.web.core.windows.net/master/CloudiwayAgent.msi' -OutFile $tmp

Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/i $tmp TARGETDIR=$cdw /qn COMPANYKEY=e446415e-74f5-42cf-9779-0e05e8846043;https://fisherstechapi.cloudiway.com" -Wait

Start-Process powershell -Credential $usr -ArgumentList "-noprofile -command &{ Start-Process -FilePath 'CloudiwayAgent.exe' -WorkingDirectory $cdw -Verb runAs}"
