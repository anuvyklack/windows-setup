# Download gsudo
# ===============

$release = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/gerardog/gsudo/releases/latest"
$asset = $release.assets | Where-Object name -like *.zip
$destdir = "$env:TEMP"
$zipfile = "$env:TEMP\$($asset.name)"

Write-Output "Downloading $($asset.name)"
Invoke-RestMethod -Method Get -Uri $asset.browser_download_url -OutFile $zipfile

Write-Output "Extracting to $destdir"
Expand-Archive -Path $zipfile -DestinationPath $destdir -Force
Remove-Item -Path $zipfile


# Conigure Windows host for Ansible
# =================================

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:Temp\ConfigureRemotingForAnsible.ps1"

Write-Output "Downloading ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

& "$env:TEMP\gsudo.exe" powershell.exe -ExecutionPolicy RemoteSigned -File $file -EnableCredSSP -DisableBasicAuth -SkipNetworkProfileCheck --verbose


# Delete all temporary files
# =================================

Write-Output "Remove all temporary files"
Remove-Item -Path $file
Remove-Item -Path $env:TEMP\gsudo.exe

Write-Output "Done!"
# Start-Sleep -Seconds 5
