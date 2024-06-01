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
            winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
        } catch {
            Write-Error "Failed to install Windows Terminal. Error: $_"
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
            winget install --id Microsoft.Powershell --e --accept-source-agreements --accept-package-agreements
        } catch {
            Write-Error "Failed to install PowerShell 7. Error: $_"
            break
        }
    } else {
        Write-Host "PowerShell 7 is already installed."
    }
}
Check-InstallPowerShell7

# install/upgrade WINGET package installer (pwshell)
try {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}
catch {
    Write-Error "Failed to install/upgrade WINGET package. Error: $_"
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
            New-Item -Path $profilePath -ItemType "directory"
        }

        Invoke-RestMethod https://github.com/tejasholla/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created."
        Write-Host "If you want to add any persistent components, please do so at [$profilePath\Profile.ps1] as there is an updater in the installed profile which uses the hash to update the profile and will lead to loss of changes"
    }
    catch {
        Write-Error "Failed to create or update the profile. Error: $_"
    }
}
else {
    try {
        Get-Item -Path $PROFILE | Move-Item -Destination "oldprofile.ps1" -Force
        Invoke-RestMethod https://github.com/tejasholla/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE
        Write-Host "The profile @ [$PROFILE] has been created and old profile removed."
        Write-Host "Please back up any persistent components of your old profile to [$HOME\Documents\PowerShell\Profile.ps1] as there is an updater in the installed profile which uses the hash to update the profile and will lead to loss of changes"
    }
    catch {
        Write-Error "Failed to backup and update the profile. Error: $_"
    }
}

# OMP Install
try {
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
}
catch {
    Write-Error "Failed to install Oh My Posh. Error: $_"
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
    }
}
catch {
    Write-Error "Failed to download or install the Cascadia Code font. Error: $_"
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
}
catch {
    Write-Error "Failed to install Chocolatey. Error: $_"
}

# Scoop install
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop is not installed. Installing Scoop..."
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "Scoop is already installed."
}

# Make Scoop downloads faster
scoop install aria2
scoop config aria2-warning-enabled false

# Install git
scoop install git

# Fastfetch install
scoop install fastfetch
Rename-Item -Path "~/.config/fastfetch/config.jsonc" -NewName ("config." + (Get-Date -Format 'dd-MM-yyyy.HH.mm.ss') + ".jsonc") -erroraction 'silentlycontinue'
fastfetch --gen-config
del ~\.config\fastfetch\config.jsonc
Copy-Item -Path ~\scoop\apps\fastfetch\current\presets\paleofetch.jsonc -Destination ~/.config/fastfetch/config.jsonc

# GUI is bloat
scoop bucket add extras
scoop install vcredist2010
scoop install ffmpeg

# sudo
scoop install gsudo

# install/upgrade notepad++ (winget)
try {
    winget install notepad++.notepad++
}
catch {
    Write-Error "Failed to install/upgrade notepad++. Error: $_"
}

try {
    winget install neovim.neovim
}
catch {
    Write-Error "Failed to install/upgrade neovim. Error: $_"
}

# Required: Backup the existing Neovim configuration
try {
    Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -Force
}
catch {
    Write-Error "Failed to backup the existing Neovim configuration. Error: $_"
}

# Optional but recommended: Backup the existing Neovim data and clone LazyVim starter
try {
    Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -Force
}
catch {
    Write-Error "Failed to backup the existing Neovim data. Error: $_"
}

try {
    git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
    Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
}
catch {
    Write-Error "Failed to clone LazyVim starter or remove .git folder. Error: $_"
}

scoop install ripgrep
scoop install fd
scoop install lazygit

# Pester Install
try {
    Install-Module -Name Pester -Force -SkipPublisherCheck
}
catch {
    Write-Error "Failed to install Pester module. Error: $_"
}

# Terminal Icons Install
try {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
}
catch {
    Write-Error "Failed to install Terminal Icons module. Error: $_"
}

# PSFzf Install
try {
    Install-Module -Name PSFzf -Scope CurrentUser -Force
}
catch {
    Write-Error "Failed to install PSFzf module. Error: $_"
}

# PSReadLine Install
try {
    Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force
}
catch {
    Write-Error "Failed to install PSReadLine module. Error: $_"
}

# fzf Install
try {
    scoop install fzf
}
catch {
    Write-Error "Failed to install fzf module. Error: $_"
}

# speedtest Install
try {
    pip install speedtest-cli
}
catch {
    Write-Error "Failed to install speedtest module. Error: $_"
}

# zoxide Install
try {
    winget install -e --id ajeetdsouza.zoxide
    Write-Host "zoxide installed successfully."
}
catch {
    Write-Error "Failed to install zoxide. Error: $_"
}

# CompletionPredictor Install
try {
    Install-Module -Name CompletionPredictor -Scope CurrentUser -Force -SkipPublisherCheck
    Write-Host "CompletionPredictor installed successfully."
}
catch {
    Write-Error "Failed to install CompletionPredictor. Error: $_"
}

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($false) {

		& wsl --install

	} else {
		"👉 Step 1/3: Enable WSL..."
		& dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

		"👉 Step 2/3: Enable virtual machine platform..."
		& dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

		"👉 Step 3/3: Enable WSL version 2..."
		& wsl --set-default-version 2
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Windows Subsystem for Linux (WSL) in $Elapsed sec"
	"  NOTE: reboot now, then visit the Microsoft Store and install a Linux distribution (e.g. Ubuntu, openSUSE, SUSE Linux, Kali Linux, Debian, Fedora, Pengwin, or Alpine)"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
}