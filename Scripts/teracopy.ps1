try {
    # Install TeraCopy using winget
    Write-Output "Installing TeraCopy via winget..."
    winget install --id=CodeSector.TeraCopy --silent --accept-package-agreements --accept-source-agreements

    # Add TeraCopy context menu for files
    Write-Output "Setting up TeraCopy as default file handler..."
    $teraCopyPath = "C:\Program Files\TeraCopy\TeraCopy.exe"

    if (Test-Path $teraCopyPath) {
        New-Item -Path "HKCU:\Software\Classes\*\shell\TeraCopy" -Force | Out-Null
        New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\TeraCopy" -Name "(default)" -Value "Copy with TeraCopy" -Force | Out-Null
        New-Item -Path "HKCU:\Software\Classes\*\shell\TeraCopy\command" -Force | Out-Null
        New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\TeraCopy\command" -Name "(default)" -Value "`"$teraCopyPath`" Copy `"%1`"" -Force | Out-Null

        # Add TeraCopy context menu for folders
        New-Item -Path "HKCU:\Software\Classes\Directory\shell\TeraCopy" -Force | Out-Null
        New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\TeraCopy" -Name "(default)" -Value "Copy with TeraCopy" -Force | Out-Null
        New-Item -Path "HKCU:\Software\Classes\Directory\shell\TeraCopy\command" -Force | Out-Null
        New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\TeraCopy\command" -Name "(default)" -Value "`"$teraCopyPath`" Copy `"%1`"" -Force | Out-Null

        # Set TeraCopy as the default handler for copy operations
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "CopyHandlers" -Value "`"$teraCopyPath`" Copy `"%1`"" -Force

        # Restart Windows Explorer to apply changes
        Write-Output "Restarting Windows Explorer to apply changes..."
        Stop-Process -Name explorer -Force
        Start-Process explorer.exe

        Write-Output "TeraCopy installation and setup complete."
    }
    else {
        Write-Output "TeraCopy installation failed. The path $teraCopyPath does not exist."
    }
}
catch {
    Write-Output "An error occurred: $_"
}
