# Ensure the script can run with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Function to test internet connectivity
function Test-InternetConnection {
    try {
        $testConnection = Test-Connection -ComputerName www.google.com -Count 1 -ErrorAction Stop
        return $true
    }
    catch {
        Write-Warning "Internet connection is required but not available. Please check your connection."
        return $false
    }
}

# Check for internet connectivity before proceeding
if (-not (Test-InternetConnection)) {
    break
}

# Check if Windows Terminal is installed
function Check-InstallWindowsTerminal {
    if (!(Get-Command -Name "wt" -ErrorAction SilentlyContinue)) {
        Write-Host "Windows Terminal not found. Installing Windows Terminal..."
        try {
            winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements -q
        } catch {
            Write-Error "Failed to install Windows Terminal."
            break
        }
    } else {
        Write-Host "Windows Terminal is already installed."
    }
}
Check-InstallWindowsTerminal

# Check if PowerShell 7 is installed
function Check-InstallPowerShell7 {
    if (-not (Get-Command -Name "pwsh" -ErrorAction SilentlyContinue)) {
        Write-Host "PowerShell 7 not found. Installing PowerShell 7..."
        try {
            winget install --id Microsoft.Powershell --e --accept-source-agreements --accept-package-agreements -q
        } catch {
            Write-Error "Failed to install PowerShell 7."
            break
        }
    } else {
        Write-Host "PowerShell 7 is already installed."
    }
}
Check-InstallPowerShell7

# install/upgrade WINGET package installer (pwshell)
try {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -ErrorAction SilentlyContinue
}
catch {
    Write-Error "Failed to install/upgrade WINGET package."
}

# Profile creation or update
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
        # Detect Version of PowerShell & Create Profile directories if they do not exist.
        $profilePath = ""
        if ($PSVersionTable.PSEdition -eq "Core") { 
            $profilePath = "$env:userprofile\Documents\Powershell"
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            $profilePath = "$env:userprofile\Documents\WindowsPowerShell"
        }

        if (!(Test-Path -Path $profilePath)) {
            New-Item -Path $profilePath -ItemType "directory" -Force -ErrorAction SilentlyContinue
        }

        Invoke-RestMethod https://github.com/tejasholla/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE -ErrorAction SilentlyContinue
        Write-Host "The profile @ [$PROFILE] has been created."
        Write-Host "If you want to add any persistent components, please do so at [$profilePath\Profile.ps1] as there is an updater in the installed profile which uses the hash to update the profile and will lead to loss of changes"
    }
    catch {
        Write-Error "Failed to create or update the profile."
    }
}
else {
    try {
        Get-Item -Path $PROFILE | Move-Item -Destination "oldprofile.ps1" -Force -ErrorAction SilentlyContinue
        Invoke-RestMethod https://github.com/tejasholla/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE -ErrorAction SilentlyContinue
        Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
        Write-Host "Please back up any persistent components of your old profile to [$HOME\Documents\PowerShell\Profile.ps1] as there is an updater in the installed profile which uses the hash to update the profile and will lead to loss of changes"
    }
    catch {
        Write-Error "Failed to backup and update the profile."
    }
}

# OMP Install
try {
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh -q
    Write-Host "Oh My Posh installed successfully."
}
catch {
    Write-Error "Failed to install Oh My Posh."
}

# Font Install
try {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name

    if ($fontFamilies -notcontains "CaskaydiaCove NF") {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFileAsync((New-Object System.Uri("https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip")), ".\CascadiaCode.zip")
        
        while ($webClient.IsBusy) {
            Start-Sleep -Seconds 2
        }

        Expand-Archive -Path ".\CascadiaCode.zip" -DestinationPath ".\CascadiaCode" -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path ".\CascadiaCode" -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
                $destination.CopyHere($_.FullName, 0x10)
            }
        }

        Remove-Item -Path ".\CascadiaCode" -Recurse -Force
        Remove-Item -Path ".\CascadiaCode.zip" -Force
        Write-Host "Cascadia Code font installed successfully."
    }
}
catch {
    Write-Error "Failed to download or install the Cascadia Code font."
}

# Final check and message to the user
if ((Test-Path -Path $PROFILE) -and (winget list --name "OhMyPosh" -e) -and ($fontFamilies -contains "CaskaydiaCove NF")) {
    Write-Host "Setup completed successfully. Please restart your PowerShell session to apply changes."
} else {
    Write-Warning "Setup completed with errors. Please check the error messages above."
}

# Choco install
try {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey installed successfully."
}
catch {
    Write-Error "Failed to install Chocolatey."
}

# Scoop install
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop is not installed. Installing Scoop..."
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression -ErrorAction SilentlyContinue
    Write-Host "Scoop installed successfully."
} else {
    Write-Host "Scoop is already installed."
}

# Make Scoop downloads faster
scoop install aria2 -q
scoop config aria2-warning-enabled false -q

# Install git
scoop install git -q

# Fastfetch install
scoop install fastfetch -q
Rename-Item -Path "~/.config/fastfetch/config.jsonc" -NewName ("config." + (Get-Date -Format 'dd-MM-yyyy.HH.mm.ss') + ".jsonc") -ErrorAction SilentlyContinue
fastfetch --gen-config
Remove-Item ~\.config\fastfetch\config.jsonc -Force
Copy-Item -Path ~\scoop\apps\fastfetch\current\presets\paleofetch.jsonc -Destination ~/.config/fastfetch/config.jsonc -Force

# GUI is bloat
scoop install vcredist2010 -q
scoop install ffmpeg -q

# sudo
scoop install gsudo -q

# install/upgrade notepad++ (winget)
try {
    winget install notepad++.notepad++ -q
    Write-Host "Notepad++ installed successfully."
}
catch {
    Write-Error "Failed to install/upgrade Notepad++."
}

# Install neovim nightly
scoop bucket add versions -q

# install/upgrade neovim
try {
    scoop install neovim -q
    scoop update neovim -q
    Write-Host "Neovim installed/updated successfully."
}
catch {
    Write-Error "Failed to install/upgrade Neovim."
}

# Install ripgrep
scoop install ripgrep -q

# Install fd
scoop install fd -q

# Install lazygit
scoop install lazygit -q

# Install universal-ctags
scoop bucket add extras -q
scoop install universal-ctags -q

# Install 7zip
scoop install 7zip -q

# Install alacritty
scoop install alacritty -q
