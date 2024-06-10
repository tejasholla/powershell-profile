# Set PowerShell to use UTF-8 encoding for both input and output
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

### PowerShell Profile Refactor
### Version 1.03 - Refactored

# Initial GitHub.com connectivity check with 1 second timeout
$canConnectToGitHub = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1

# Import Modules and External Profiles
# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

Import-Module -Name z

# Enhanced PowerShell Experience
Set-PSReadLineOption -Colors @{
    Command = '#f6de4b'
    Parameter = 'Green'
    String = 'DarkCyan'
    Operator = 'Magenta'
    ContinuationPrompt = '#56B6C2'
    Error = '#E06C75'
    Variable = 'Yellow'  
    Number = 'Red'
    Type = 'Cyan'
    Comment = 'DarkCyan'
    InlinePrediction = '#70A99F'
}

# PSReadLine configuration
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -BellStyle Visual
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -MaximumHistoryCount 4096
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistorySearchCaseSensitive:$false
Set-PSReadLineOption -HistoryNoDuplicates:$true

Set-PSReadLineKeyHandler -Key Alt+e `
	-BriefDescription "CWD" `
	-LongDescription "Open the current working directory in the Windows Explorer" `
	-ScriptBlock { Start-Process explorer -ArgumentList '.' }

$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock

# Fzf configuration
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# CompletionPredictor Configuration
Import-Module -Name CompletionPredictor

# Environment variables
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Check for Fastfetch Updates
function Update-FastFetch {
    if (-not $global:canConnectToGitHub) {
        return
    }

    try {
        $updateNeeded = $false
        $currentVersion = Get-Command fastfetch | Select-Object -ExpandProperty Version
        $gitHubApiUrl = "https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest"

        if ($env:pwsh_github_api) {
            $headers = @{
                "Authorization" = "token $env:pwsh_github_api"
            }
            $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl -Headers $headers
        } else {
            $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        }

        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }

        if ($updateNeeded) {
            scoop update fastfetch
        }
    } catch {
        Write-Error "Failed to update FastFetch. Error: $_"
    }
}

Update-FastFetch

# Display Fastfetch
cls
fastfetch -l "Windows 11"

function Update-Profile {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping profile update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try {
        $url = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Microsoft.PowerShell_profile.ps1"
        $oldhash = Get-FileHash $PROFILE
        Invoke-RestMethod $url -OutFile "$env:temp/Microsoft.PowerShell_profile.ps1"
        $newhash = Get-FileHash "$env:temp/Microsoft.PowerShell_profile.ps1"
        if ($newhash.Hash -ne $oldhash.Hash) {
            Copy-Item -Path "$env:temp/Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
            Write-Host "Profile has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        }
    } catch {
        Write-Error "Unable to check for `$profile updates"
    } finally {
        Remove-Item "$env:temp/Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue
    }
}
Update-Profile

function Update-PowerShell {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }

    try {
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }

        if ($updateNeeded) {
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        }
    } catch {
        Write-Error "Failed to update PowerShell. Error: $_"
    }
}
Update-PowerShell

# Admin Check and Prompt Customization
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt {
    if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
}
$adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()

function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

# sudo function
Import-Module "gsudoModule"

# Set aliases for quick access --------------------------------------------------------------------------------------------------
Set-Alias -Name su -Value admin
Set-Alias sudo gsudo
Set-Alias li ls
Set-Alias g git
Set-Alias ip ipconfig
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
set-Alias anydesk 'C:\Program Files (x86)\AnyDesk\AnyDesk.exe'
set-Alias task 'C:\WINDOWS\system32\Taskmgr.exe'
set-Alias cpl 'D:\apps\Control Panel.lnk'
set-Alias nucommand 'D:\apps\nu_commands.txt'
Set-Alias nuopen nu
set-Alias touch Set-FreshFile
set-Alias ff Find-Files
set-Alias unzip Expand-File
set-Alias mkdir New-Directory
set-Alias root Set-Home
Set-Alias -Name vi -Value Launch-Nvim -Description "Launch neovim"
Set-Alias -Name vim -Value Launch-Nvim -Description "Launch neovim"
Set-Alias -Name nvim -Value Launch-Nvim -Description "Launch neovim"

# Function definitions ------------------------------------------------------------------------------------------------------------
function profile {
	$path = Join-Path $env:USERPROFILE 'Documents\PowerShell'
	Start-Process $path
}

function Edit-Profile { notepad++ "$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }

function reload-profile { & $profile }

# app related --------------------------------------------------------------------------------------------------------------------
function npp { Start-Process -FilePath "C:\Program Files\Notepad++\Notepad++.exe" -ArgumentList $args }

function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Editor Configuration
$EDITOR = if (Test-CommandExists nvim) { 'nvim' }
          elseif (Test-CommandExists vim) { 'nvim' }
          elseif (Test-CommandExists vi) { 'nvim' }
          elseif (Test-CommandExists code) { 'code' }
          elseif (Test-CommandExists notepad++) { 'npp' }
          else { 'notepad' }
Set-Alias -Name vim -Value $EDITOR

function Launch-Nvim {
	$mycmd = "nvim"
	$cmd = where.exe $mycmd
	if ( Get-Command "wt" -ErrorAction SilentlyContinue ) {
		$command = "wt"
		$cargs = "$cmd $args"
	} else {
		$command = "cmd"
		$cargs = "/c $cmd $args"
	}
	Write-Host "command: [$command] cargs: [$cargs]"
	$parameters = $cargs -join ' '
	if ($parameters) {
		Start-Process -FilePath $command -ArgumentList $parameters
	} else {
		Start-Process -FilePath $command
	}
}

function notes { vim "$Env:USERPROFILE\Documents\Notes.txt" }

function keybind {
	$path = Join-Path $env:USERPROFILE 'Pictures\Screenshots\Terminal_keys'
 	Start-Process $path
 }

function ex{explorer .}

function telegram{start https://web.telegram.org/a/}

function photos{start https://photos.google.com/}

function imagecompress{start https://www.iloveimg.com/compress-image}

# Download functions -------------------------------------------------------------------------------------------------------------
function ytdownload {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/yt-download.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

# Browser related ----------------------------------------------------------------------------------------------------------------
function browser {
    $path = Join-Path $env:USERPROFILE 'AppData\Local\Thorium\Application\thorium.exe'
    Start-Process $path
}

function edge { Start-Process "msedge" }

function gs{start www.google.com/search?q=$args}

function google{start www.google.com}

function ys{start www.youtube.com/search?q=$args}

function youtube{start www.youtube.com}

function wiki{start https://www.wikiwand.com/en/$args}

function url {
    param(
        [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    $target = $args[0]
    if (Test-Path $target) {
        Start-Process $target -ErrorAction SilentlyContinue
    } else {
        Start-Process "https://$target"
    }
}

# windows defender ----------------------------------------------------------------------------------------------------------------
function windef {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/windefender.ps1"
    
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptPath -ErrorAction Stop
        
        # Remove BOM if present
        if ($scriptContent[0] -eq 0xFEFF) {
            $scriptContent = $scriptContent.Substring(1)
        }
        
        Invoke-Expression $scriptContent
    } catch {
        Write-Host "⚠️ Error fetching or executing the script: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Enhanced Listing -----------------------------------------------------------------------------------------------------------------
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }

function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

function lscheck{nu -c "ls $args"}

function lsnu{nu -c "ls"}

function lscommand{nu -c "$args"}

# Git Shortcuts -----------------------------------------------------------------------------------------------------------------
function github{start https://github.com/tejasholla}

function gitrepo{start https://github.com/tejasholla?tab=repositories}

function gituser { git config --global user.name "$args" }

function gitemail { git config --global user.email "$args" }

function gitlist { git config --list }

function gst { git status }

function ga { git add . }

function gadd {git add "$args"}

function gc { param($m) git commit -m "$m" }

function gcl { git clone "$args" }

function gp { git push }

function gi { git init }

function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

function graph {git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all}

function ss {git status --short}

function nuke {git reset --hard; git clean -xdf}

# Quick Access to System Information -----------------------------------------------------------------------------------------------------------------
function sysinfo { Get-ComputerInfo }

function pcdata {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/hw.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function powcheck { powercfg /energy }

function batcheck { powercfg /batteryreport }

function scanfile { sfc /scannow }

function checkhealth { DISM /Online /Cleanup-Image /CheckHealth }

function scanhealth { DISM /Online /Cleanup-Image /ScanHealth }

function restorehealth { DISM /Online /Cleanup-Image /RestoreHealth }

# Networking Utilities -----------------------------------------------------------------------------------------------------------------
function online {
	param($computername)
	return (test-connection $computername -count 1 -quiet)
}

function flushdns { Clear-DnsClientCache }

Function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip ).Content }

function ipall { ipconfig /all }

function ipnew {
        ipconfig /release
	  ipconfig /renew
}

function ipflush { ipconfig /flushdns }

function wifinetwork{netsh wlan show profile}

function thiswifi{netsh wlan show profile $args key=clear | findstr “Key Content”}

function networkdetails{netsh wlan show interfaces}

# NetworkSpeed check
function NetworkSpeed {
    try {
        $output = speedtest-cli --simple
        $lines = $output -split "\n"

        foreach ($line in $lines) {
            if ($line -like "*Ping*") {
                Write-Host $line -ForegroundColor Cyan
            }
            elseif ($line -like "*Download*") {
                Write-Host $line -ForegroundColor Green
            }
            elseif ($line -like "*Upload*") {
                Write-Host $line -ForegroundColor Magenta
            }
            else {
                Write-Host $line
            }
        }
    } catch {
        Write-Host "Failed to perform speed test. Error: $_" -ForegroundColor Red
    }
}

function Get-HWVersion($computer, $name) {

    $pingresult = Get-WmiObject win32_pingstatus -f "address='$computer'"
    if($pingresult.statuscode -ne 0) { return }

    Get-WmiObject -Query "SELECT * FROM Win32_PnPSignedDriver WHERE DeviceName LIKE '%$name%'" -ComputerName $computer | 
          Sort DeviceName | 
          Select @{Name="Server";Expression={$_.__Server}}, DeviceName, @{Name="DriverDate";Expression={[System.Management.ManagementDateTimeconverter]::ToDateTime($_.DriverDate).ToString("MM/dd/yyyy")}}, DriverVersion
}

function ipchange {
        # Assuming the script is accessible via the URL
        $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/ip-change.ps1"
        $scriptContent = Invoke-RestMethod -Uri $scriptPath
        Invoke-Expression $scriptContent
}

function iplocate {
    # Path to the script on GitHub
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/locate-ipaddress.ps1"
    
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptPath -ErrorAction Stop
        
        # Remove BOM if present
        if ($scriptContent[0] -eq 0xFEFF) {
            $scriptContent = $scriptContent.Substring(1)
        }

        # Save script content to a temporary file
        $tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
        Set-Content -Path $tempScriptPath -Value $scriptContent

        . $tempScriptPath
        
        # Cleanup the temporary file
        Remove-Item -Path $tempScriptPath -Force
    } catch {
        Write-Host "⚠️ Error fetching or executing the script: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Clipboard Utilities -----------------------------------------------------------------------------------------------------------------
function cpy { Set-Clipboard $args[0] }

function pst { Get-Clipboard }

# file related --------------------------------------------------------------------------------------------------------------------
function Set-Home {
    [CmdletBinding()]
    [Alias("root")]
    param (
      # This function does not accept any parameters
    )
    Set-Location -Path $HOME
  }

function cdc { set-location C:\ }

function cdd { set-location D:\ }

function cde { set-location E:\ }

function Expand-File {
    [CmdletBinding()]
    [Alias("unzip")]
    param (
      [Parameter(Mandatory = $true, Position = 0)]
      [string]$File
    )
  
    BEGIN {
      Write-Host "Starting file extraction process..." -ForegroundColor Cyan
    }
  
    PROCESS {
      try {
        Write-Host "Extracting file '$File' to '$PWD'..." -ForegroundColor Cyan
        $FullFilePath = Get-Item -Path $File -ErrorAction Stop | Select-Object -ExpandProperty FullName
        Expand-Archive -Path $FullFilePath -DestinationPath $PWD -Force -ErrorAction Stop
        Write-Host "File extraction completed successfully." -ForegroundColor Green
      }
      catch {
        Write-Error "Failed to extract file '$File'. Error: $_"
      }
    }
  
    END {
      if (-not $Error) {
        Write-Host "File extraction process completed." -ForegroundColor Cyan
      }
    }
  }

function grep($regex, $dir) {
        if ( $dir ) {
                Get-ChildItem $dir | select-string $regex
                return
        }
        $input | select-string $regex
}

function df { get-volume }

function sed($file, $find, $replace){
        (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function export($name, $value) {
        set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
        Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) { Get-Process $name }

# Specifies the name of the file to create or update. If the file already exists, its timestamp will be updated.
function Set-FreshFile {
    [CmdletBinding()]
    [Alias("touch")]
    param (
      [Parameter(Mandatory = $true)]
      [string]$File
    )
  
    # Check if the file exists
    if (Test-Path $File) {
      # If the file exists, update its timestamp
        (Get-Item $File).LastWriteTime = Get-Date
    }
    else {
      # If the file doesn't exist, create it with an empty content
      "" | Out-File $File -Encoding ASCII
    }
  }
 
# Find-Files
function Find-Files {
    [CmdletBinding()]
    [Alias("ff")]
    param (
      [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [string]$Name
    )
    
    # Search for files matching the specified name pattern
    Get-ChildItem -Recurse -Filter $Name -ErrorAction SilentlyContinue | ForEach-Object {
      Write-Output $_.FullName
    }
}

function New-Directory {
    [CmdletBinding()]
    [Alias("mkcd")]
    param (
      [Parameter(Position = 0, Mandatory = $true)]
      [string]$name
    )
  
    try {
      $newDir = New-Item -Path $PWD -Name $name -ItemType Directory -ErrorAction Stop
      Set-Location -Path $newDir.FullName
    }
    catch {
      Write-Warning "Failed to create directory '$name'. Error: $_"
    }
}

function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }

# Recycle bin functions -----------------------------------------------------------------------------------------------------------
function binop {
    $RecycleBin = (New-Object -ComObject Shell.Application).Namespace(0xA)
    $RecycleBin.Self.InvokeVerb('open')
}

function binclean {
    try {
        $recycleBin = (New-Object -ComObject Shell.Application).NameSpace(0xA)
        $items = $recycleBin.Items()

        if ($items.Count -eq 0) {
            Write-Host "The Recycle Bin is already empty." -ForegroundColor Green
            return
        }
        $totalItems = $items.Count
        $currentItem = 0

        $items | ForEach-Object {
            $currentItem++
            $itemPath = $_.Path

            try {
                Remove-Item $itemPath -Force -Recurse -ErrorAction Stop
            } catch {
                Write-Host "Failed to delete: $itemPath" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "An error occurred while accessing the Recycle Bin: $_" -ForegroundColor Red
    }
    Write-Host "Recycle Bin cleanup complete."
}

# weather function ---------------------------------------------------------------------------------------------------------------------
function weatherfun{curl wttr.in/$args}

function weather {
    # Path to the script on GitHub
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/list-weather.ps1"
    
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptPath -ErrorAction Stop
        
        # Remove BOM if present
        if ($scriptContent[0] -eq 0xFEFF) {
            $scriptContent = $scriptContent.Substring(1)
        }

        # Save script content to a temporary file
        $tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
        Set-Content -Path $tempScriptPath -Value $scriptContent

        . $tempScriptPath
        
        # Cleanup the temporary file
        Remove-Item -Path $tempScriptPath -Force
    } catch {
        Write-Host "⚠️ Error fetching or executing the script: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# other functions --------------------------------------------------------------------------------------------------------------------------
function checkpass {
    # Path to the script on GitHub
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/check-password.ps1"
    
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptPath -ErrorAction Stop
        
        # Remove BOM if present
        if ($scriptContent[0] -eq 0xFEFF) {
            $scriptContent = $scriptContent.Substring(1)
        }

        # Save script content to a temporary file
        $tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
        Set-Content -Path $tempScriptPath -Value $scriptContent

        . $tempScriptPath
        
        # Cleanup the temporary file
        Remove-Item -Path $tempScriptPath -Force
    } catch {
        Write-Host "⚠️ Error fetching or executing the script: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function timezone {
    try {
        [system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
        Get-Timezone 
    } catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    }
}

function qr {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/qr.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function usb {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/usb-toggle.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function shellhere {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/PowerShellHere.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function hb {
    if ($args.Length -eq 0) {
        Write-Error "No file path specified."
        return
    }
    
    $FilePath = $args[0]
    
    if (Test-Path $FilePath) {
        $Content = Get-Content $FilePath -Raw
    } else {
        Write-Error "File path does not exist."
        return
    }
    
    $uri = "http://bin.christitus.com/documents"
    try {
        $response = Invoke-RestMethod -Uri $uri -Method Post -Body $Content -ErrorAction Stop
        $hasteKey = $response.key
        $url = "http://bin.christitus.com/$hasteKey"
        Write-Output $url
    } catch {
        Write-Error "Failed to upload the document. Error: $_"
    }
}

function debloat {
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "irm https://christitus.com/win | iex"
}

function setup {irm "https://github.com/tejasholla/powershell-profile/raw/main/setup.ps1" | iex}

# Shortens a URL using various free URL shortening services.
function shorturl {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/short-url.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath

    # Save the script content to a temporary file
    $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"
    Set-Content -Path $tempFile -Value $scriptContent

    # Execute the temporary script file
    . $tempFile

    # Remove the temporary file
    Remove-Item -Path $tempFile -Force
}


function reset-wsl {
    cd $env:LOCALAPPDATA\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\
    wsl --shutdown
    Write-Host "WSL shutdown..."
    cd
}

function linux {Start-Process wt -ArgumentList @('-w', '0', 'nt', 'wsl')}

# AI run functions -----------------------------------------------------------------------------------------------------------------
function chatgpt{start https://chatgpt.com/}

function chatty {
    start http://localhost:8080/
    
    # Open WSL in a new Windows Terminal tab
    linux
}

# Utility functions ----------------------------------------------------------------------------------------------------------------------------------
function Get-Theme {
    if (Test-Path -Path $PROFILE.CurrentUserAllHosts -PathType leaf) {
        $existingTheme = Select-String -Raw -Path $PROFILE.CurrentUserAllHosts -Pattern "oh-my-posh init pwsh --config"
        if ($null -ne $existingTheme) { # $null
            Invoke-Expression $existingTheme
            return
        }
    } else {
        oh-my-posh init pwsh --config https://raw.githubusercontent.com/tejasholla/powershell-profile/main/custommade.omp.json | Invoke-Expression
    }
}
Get-Theme

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    # Invoke-Expression (& { (zoxide init powershell | Out-String) })
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
} else {
    Write-Host "zoxide command not found. Attempting to install via winget..."
    try {
        winget install -e --id ajeetdsouza.zoxide
        Write-Host "zoxide installed successfully. Initializing..."
        # Invoke-Expression (& { (zoxide init powershell | Out-String) })
        Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
    } catch {
        Write-Error "Failed to install zoxide. Error: $_"
    }
}