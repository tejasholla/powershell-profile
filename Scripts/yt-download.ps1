function ytdownloadfun {
    $path = 'D:\Git\ytDownloader'
    $file = 'ytDownloader.py'
    $fullPath = Join-Path $path $file
    $python310Path = Join-Path $env:USERPROFILE 'AppData\Local\Programs\Python\Python310\python.exe'
    $python312Path = Join-Path $env:USERPROFILE 'AppData\Local\Programs\Python\Python312\python.exe'
    $gitRepo = 'https://github.com/tejasholla/ytDownloader.git'
    $gitPath = 'C:\Program Files\Git\bin\git.exe'

    # Check if the directory exists
    if (-Not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force
        Write-Host "Downloading ytDownloader from GitHub..."
        if (Test-Path $gitPath) {
            & $gitPath clone $gitRepo $path
            Write-Host "Download complete."
        } else {
            Write-Host "Git is not installed. Please install Git or add it to your PATH."
            return
        }
    } else {
        Write-Host "Checking for updates..."
        Set-Location -Path $path
        & $gitPath fetch
        $statusOutput = & $gitPath status -uno
        if ($statusOutput -match "Your branch is behind") {
            Write-Host "Updates found. Pulling changes..."
            & $gitPath pull
            Write-Host "Update complete."
        } else {
            Write-Host "No updates found."
        }
        Set-Location -Path $pwd
    }

    # Execute the Python script if it exists
    if (Test-Path $fullPath) {
        & $python312Path $fullPath
    } else {
        Write-Host "The script file does not exist even after attempting to download. Please check the repository URL and directory permissions."
    }
}

ytdownloadfun