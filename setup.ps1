# Ensure the script can run with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Function to test internet connectivity
function Test-InternetConnection {
    try {
        Test-Connection -ComputerName www.google.com -Count 1 -ErrorAction Stop | Out-Null
        return $true
    } catch {
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
        Write-Host "Installing Windows Terminal..."
        try {
            winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements -h
        } catch {
            Write-Host "Error: Failed to install Windows Terminal."
        }
    } else {
        Write-Host "Windows Terminal is already installed."
    }
}

Check-InstallWindowsTerminal

# Check if PowerShell 7 is installed
function Check-InstallPowerShell7 {
    if (-not (Get-Command -Name "pwsh" -ErrorAction SilentlyContinue)) {
        Write-Host "Installing PowerShell 7..."
        try {
            winget install --id Microsoft.Powershell --e --accept-source-agreements --accept-package-agreements
        } catch {
            Write-Host "Error: Failed to install PowerShell 7."
        }
    } else {
        Write-Host "PowerShell 7 is already installed."
    }
}

Check-InstallPowerShell7

# Profile creation or update
if (!(Test-Path -Path $PROFILE -PathType Leaf)) {
    try {
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
        Write-Host "Applying PowerShell profile..."
    } catch {
        Write-Host "Error: Failed to create or update the profile."
    }
} else {
    try {
        Get-Item -Path $PROFILE | Move-Item -Destination "oldprofile.ps1" -Force
        Invoke-RestMethod https://github.com/tejasholla/powershell-profile/raw/main/Microsoft.PowerShell_profile.ps1 -OutFile $PROFILE
        Write-Host "Applying PowerShell profile..."
    } catch {
        Write-Host "Error: Failed to backup and update the profile."
    }
}

# Oh My Posh Install
try {
    Write-Host "Installing Oh-My-Posh & theme..."
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
} catch {
    Write-Host "Error: Failed to install Oh My Posh."
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
        Write-Host "Installing Caskaydia Cove Nerd fonts..."
    } else {
        Write-Host "Caskaydia Cove Nerd fonts are already installed."
    }
} catch {
    Write-Host "Error: Failed to download or install the Cascadia Code font."
}

# Pester Install
try {
    Write-Host "Installing Pester..."
    Install-Module -Name Pester -Force -SkipPublisherCheck
} catch {
    Write-Host "Error: Failed to install Pester module."
}

# Terminal Icons Install
try {
    Write-Host "Installing Terminal-Icons modules..."
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
} catch {
    Write-Host "Error: Failed to install Terminal Icons module."
}

# PSFzf Install
try {
    Write-Host "Installing PSFzf..."
    Install-Module -Name PSFzf -Scope CurrentUser -Force
} catch {
    Write-Host "Error: Failed to install PSFzf module."
}

# PSReadLine Install
try {
    Write-Host "Installing PSReadLine..."
    Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force
} catch {
    Write-Host "Error: Failed to install PSReadLine module."
}

# fzf Install
try {
    Write-Host "Installing fzf..."
    scoop install fzf
} catch {
    Write-Host "Error: Failed to install fzf module."
}

# speedtest Install
try {
    Write-Host "Installing speedtest-cli..."
    pip install speedtest-cli
} catch {
    Write-Host "Error: Failed to install speedtest module."
}

# zoxide Install
try {
    Write-Host "Installing zoxide..."
    winget install -e --id ajeetdsouza.zoxide
} catch {
    Write-Host "Error: Failed to install zoxide."
}

# CompletionPredictor Install
try {
    Write-Host "Installing CompletionPredictor..."
    Install-Module -Name CompletionPredictor -Scope CurrentUser -Force -SkipPublisherCheck
} catch {
    Write-Host "Error: Failed to install CompletionPredictor."
}

# Scoop Install
try {
    Write-Host "Installing Scoop..."
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    Write-Host "Installing aria2..."
    scoop install aria2
    scoop config aria2-warning-enabled false
    Write-Host "Installing git..."
    scoop install git
    Write-Host "Installing fastfetch..."
    scoop install fastfetch
    Write-Host "Installing vcredist2010..."
    scoop install vcredist2010
    Write-Host "Installing ffmpeg..."
    scoop install ffmpeg
    Write-Host "Installing gsudo..."
    scoop install gsudo
    Write-Host "Adding versions bucket and installing neovim..."
    scoop bucket add versions
    scoop install neovim
    scoop update neovim
    Write-Host "Installing ripgrep..."
    scoop install ripgrep
    Write-Host "Installing fd..."
    scoop install fd
    Write-Host "Installing lazygit..."
    scoop install lazygit
    Write-Host "Adding extras bucket and installing universal-ctags..."
    scoop bucket add extras
    scoop install universal-ctags
    Write-Host "Installing 7zip..."
    scoop install 7zip
} catch {
    Write-Host "Error: Failed to install scoop packages."
}

# WSL Install
try {
    Write-Host "Enabling WSL..."
    & dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    Write-Host "Enabling virtual machine platform..."
    & dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Write-Host "Setting WSL version to 2..."
    & wsl --set-default-version 2
} catch {
    Write-Host "Error: Failed to enable WSL or set version."
}

# Chocolatey Install
try {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} catch {
    Write-Host "Error: Failed to install Chocolatey."
}

# Notepad++ Install
try {
    Write-Host "Installing Notepad++..."
    choco install notepadplusplus -y
} catch {
    Write-Host "Error: Failed to install Notepad++."
}

# 7zip Install
try {
    Write-Host "Installing 7zip..."
    choco install 7zip -y
} catch {
    Write-Host "Error: Failed to install 7zip."
}

# cmake Install
try {
    Write-Host "Installing cmake..."
    choco install cmake -y
} catch {
    Write-Host "Error: Failed to install cmake."
}

# Clean temporary files after installations
try {
    Write-Host "Cleaning up temporary files..."
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Error: Failed to clean temporary files."
}

Write-Host "Installation complete!"
