# Set yt-dlp path
$ytDlpPath = "$PSScriptRoot\SOURCE\yt-dlp.exe"

# Backup old version
$backupPath = "$PSScriptRoot\SOURCE\yt-dlp_backup.exe"
Copy-Item -Path $ytDlpPath -Destination $backupPath -Force

# Download new version (replace the URL with the actual download link)
$downloadUrl = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
Invoke-WebRequest -Uri $downloadUrl -OutFile $ytDlpPath

Write-Host "yt-dlp updated successfully!"
