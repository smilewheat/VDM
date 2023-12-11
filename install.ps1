# 设置字符编码为UTF-8
$OutputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 设置下载目录
$downloadDirectory = "$PSScriptRoot\SOURCE"

# 设置yt-dlp下载链接
$ytDlpDownloadUrl = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"

# 创建SOURCE目录
if (-not (Test-Path -Path $downloadDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $downloadDirectory | Out-Null
}

# 下载yt-dlp
Invoke-WebRequest -Uri $ytDlpDownloadUrl -OutFile "$downloadDirectory\yt-dlp.exe"

Write-Host "yt-dlp下载完成，文件保存在$downloadDirectory"
