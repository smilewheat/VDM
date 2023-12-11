# Set character encoding to UTF-8
$OutputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Set yt-dlp path
$ytDlpPath = "$PSScriptRoot\SOURCE\yt-dlp.exe"

# Set FFmpeg path
$ffmpegPath = "$PSScriptRoot\SOURCE\ffmpeg.exe"

# Set download directory
$downloadDirectory = "$PSScriptRoot\download"

# Function to set proxy
function Set-Proxy {
    # Input proxy server and port
    $proxyServer = Read-Host "Enter proxy server address (e.g., proxy.example.com)"
    $proxyPort = Read-Host "Enter proxy server port (e.g., 8080)"

    # Set system proxy
    [System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("${proxyServer}:${proxyPort}")
    [System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
}

# Function to add FFmpeg to system PATH
function Add-FFmpeg-To-Path {
    $env:PATH = "$env:PATH;$ffmpegPath"
}

# Display options to the user
do {
    Write-Host "1. Set Proxy"
    Write-Host "2. Download Video"

    # Ask user for choice
    $choice = Read-Host "Enter your choice (1 or 2)"

    # Process user choice
    switch ($choice) {
        1 { Set-Proxy }
        2 {
            # Temporarily add FFmpeg to system PATH
            Add-FFmpeg-To-Path

            # Input video page URL
            $videoUrl = Read-Host "Enter the video page URL"

            # List available formats
            $result = & $ytDlpPath --list-formats $videoUrl

            # Display query result
            Write-Host "Available formats:"
            $result | ForEach-Object { Write-Host $_ }

            # Input video format code
            $videoFormat = Read-Host "Enter the video format code"

            # Input audio format code
            $audioFormat = Read-Host "Enter the audio format code"

            # Create download directory
            if (-not (Test-Path -Path $downloadDirectory -PathType Container)) {
                New-Item -ItemType Directory -Path $downloadDirectory | Out-Null
            }

            # Download video and audio
            & $ytDlpPath --format "$videoFormat+$audioFormat" --output "$downloadDirectory\%(title)s.%(ext)s" $videoUrl

            Write-Host "Video downloaded, files saved in $downloadDirectory"
        }
        Default { Write-Host "Invalid choice" }
    }
} while ($true)
