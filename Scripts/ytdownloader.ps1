function ytdownloaderfun {
    $path = 'D:\Git\ytDownloader'
    $file = 'ytDownloader.py'
    $fullPath = Join-Path $path $file
    $python310Path = Join-Path $env:USERPROFILE 'AppData\Local\Programs\Python\Python310\python.exe'
    $gitRepo = 'https://github.com/tejasholla/ytDownloader.git'

    # Check if the Python file exists
    if (-Not (Test-Path $fullPath)) {
        # If the file does not exist, check if the directory exists
        if (-Not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path -Force
        }
        Write-Host "Downloading ytDownloader from GitHub..."
        # Ensure Git is available
        $gitPath = 'C:\Program Files\Git\bin\git.exe'
        if (Test-Path $gitPath) {
            & $gitPath clone $gitRepo $path
            Write-Host "Download complete. Running the script..."
        } else {
            Write-Host "Git is not installed. Please install Git or add it to your PATH."
            return
        }
    }
    # Execute the Python script if it exists
    if (Test-Path $fullPath) {
        & $python310Path $fullPath
    } else {
        Write-Host "The script file does not exist even after attempting to download. Please check the repository URL and directory permissions."
    }
}

ytdownloaderfun