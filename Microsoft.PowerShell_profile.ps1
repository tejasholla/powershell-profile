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

# Check for Profile Updates
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
        Write-Host "Checking for PowerShell updates..." -ForegroundColor Cyan
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }

        if ($updateNeeded) {
            Write-Host "Updating PowerShell..." -ForegroundColor Yellow
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        } else {
            Write-Host "Your PowerShell is up to date." -ForegroundColor Green
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

# Set aliases for quick access
Set-Alias -Name vim -Value nvim
Set-Alias -Name sudo -Value admin
Set-Alias li ls
Set-Alias g git
Set-Alias ip ipconfig
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
set-Alias anydesk 'C:\Program Files (x86)\AnyDesk\AnyDesk.exe'
set-Alias task 'C:\WINDOWS\system32\Taskmgr.exe'
set-Alias cpl 'D:\apps\Control Panel.lnk'
set-Alias winutil 'D:\apps\WinUtil.lnk'
set-Alias nucommand 'D:\apps\nu_commands.txt'
Set-Alias nuopen nu
set-Alias cr 'D:\apps\Crunchyroll - Watch Popular Anime.lnk'
set-Alias touch Set-FreshFile
set-Alias ff Find-Files
set-Alias unzip Expand-File
set-Alias mkcd New-Directory
set-Alias root Set-Home

# Function definitions
function npp { Start-Process -FilePath "C:\Program Files\Notepad++\Notepad++.exe" -ArgumentList $args }

function notes { npp "$Env:USERPROFILE\Documents\Notes.txt" }

function browser {
    $path = Join-Path $env:USERPROFILE 'AppData\Local\Thorium\Application\thorium.exe'
    Start-Process $path
}

function setup {
    irm "https://github.com/tejasholla/powershell-profile/raw/main/setup.ps1" | iex
}

function chatty {
    start http://localhost:8080/
    
    # Open WSL in a new Windows Terminal tab
    Start-Process wt -ArgumentList @('-w', '0', 'nt', 'wsl')
}

function reset-wsl {
    cd $env:LOCALAPPDATA\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\
    wsl --shutdown
    Write-Host "WSL shutdown..."
    cd
}

function binop {
    $RecycleBin = (New-Object -ComObject Shell.Application).Namespace(0xA)
    $RecycleBin.Self.InvokeVerb('open')
}

function edge { Start-Process "msedge" }

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

function usb {
    # Prompt the user for confirmation
    $response = Read-Host "For disable[1],enable[2]? "
    if ($response -eq 1) {
        # Disable USB
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 4
        Write-Host "Disabled USB devices" -ForegroundColor DarkGray
    }
    elseif ($response -eq 2) {
        # Enable USB
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 3
        Write-Host "Enabled USB devices" -ForegroundColor DarkGray
    }
    else {
        Write-Host "Invalid option" -ForegroundColor Red
    }
}

# Shortens a URL using various free URL shortening services.
function shorturl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateSet("isgd", "snipurl", "tinyurl", "chilp", "clickme", "sooogd")]
        [string]$Shortener,

        [Parameter(Mandatory = $false)]
        [string]$Link
    )
    BEGIN {
        $BaseURL = ""
        $WebClient = New-Object Net.WebClient
        $ValidUrl = $true
    }
    PROCESS {
        if (-not $Shortener) {
            $Shortener = Read-Host "Please enter the URL shortening service (isgd, snipurl, tinyurl, chilp, clickme, sooogd)"
        }
        if (-not $Link) {
            $Link = Read-Host "Please enter the URL to be shortened"
        }
        
        if (-not ([System.Uri]::TryCreate($Link, [System.UriKind]::Absolute, [ref]$null))) {
            Write-Error -Message "Invalid URL format!"
            $ValidUrl = $false
            return
        }
        switch ($Shortener) {
            "isgd" {
                $BaseURL = "https://is.gd/create.php?format=simple&url=$Link"
            }
            "snipurl" {
                $BaseURL = "http://snipurl.com/site/snip?r=simple&link=$Link"
            }
            "tinyurl" {
                $BaseURL = "http://tinyurl.com/api-create.php?url=$Link"
            }
            "chilp" {
                $BaseURL = "https://chilp.it/api.php?url=$Link"
            }
            "clickme" {
                $BaseURL = "http://cliccami.info/api/resturl/?url=$Link"
            }
            "sooogd" {
                $BaseURL = "https://soo.gd/api.php?api=&short=$Link"
            }
            default {
                Write-Error -Message "Invalid URL shortener specified. Supported options are 'snipurl', 'tinyurl', 'isgd', 'chilp', 'clickme', or 'sooogd'!"
                return
            }
        }
        if ($ValidUrl) {
            $Response = $WebClient.DownloadString("$BaseURL")
            $ShortenedUrl = $Response.Trim()
            [PSCustomObject]@{
                OriginalURL      = $Link
                ShortenedURL     = $ShortenedUrl
                Shortener        = $Shortener
                CreationDateTime = Get-Date
            }
        }
    }
    END {
        if ($WebClient) {
            $WebClient.Dispose()
        }
    }
}

function terminal_settings_fun {
	$path = Join-Path $env:USERPROFILE 'Pictures\Screenshots\Terminal_keys'
 	Start-Process $path
 }
set-alias keybind terminal_settings_fun

function online {
	param($computername)
	return (test-connection $computername -count 1 -quiet)
}

function ytplayer {
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

# network related functions
function wifinetwork{netsh wlan show profile}

function wifinetworkfun{netsh wlan show profile $args key=clear | findstr “Key Content”}
set-alias thiswifi wifinetworkfun

function networkdetails{netsh wlan show interfaces}

function expo{explorer .}

function weatherfun{curl wttr.in/$args}
set-alias weather weatherfun

function profilefun {
	$path = Join-Path $env:USERPROFILE 'Documents\PowerShell'
	Start-Process $path
}
set-alias profile profilefun

function telegram{start https://web.telegram.org/a/}

function chatgpt{start https://chatgpt.com/}

function github{start https://github.com/tejasholla}

function gitrepo{start https://github.com/tejasholla?tab=repositories}

function photosfun{start https://photos.google.com/}
set-alias photos photosfun

function imagecompress{start https://www.iloveimg.com/compress-image}

function googleSearch{start www.google.com/search?q=$args}
set-alias gs googleSearch

function googleopen{start www.google.com}
set-alias google googleopen

function youtubeSearch{start www.youtube.com/search?q=$args}
set-alias ys youtubeSearch

function youtubeopen{start www.youtube.com}
set-alias youtube youtubeopen

function wikiSearch{start https://www.wikiwand.com/en/$args}
set-alias wiki wikiSearch

function pathdatafun{nu -c "ls $args"}
set-alias lscheck pathdatafun

function lsfun{nu -c "ls"}
set-alias lsnu lsfun

function lscommandfun{nu -c "$args"}
set-alias lscommand lscommandfun

function ipall { ipconfig /all }

function ipnew {
        ipconfig /release
	  ipconfig /renew
}

function powcheck { powercfg /energy }

function batcheck { powercfg /batteryreport }

function scanfile { sfc /scannow }

function checkhealth { DISM /Online /Cleanup-Image /CheckHealth }

function scanhealth { DISM /Online /Cleanup-Image /ScanHealth }

function restorehealth { DISM /Online /Cleanup-Image /RestoreHealth }

function ipflush { ipconfig /flushdns }

function shutdown { shutdown /s }

function restart { shutdown /r }

function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }

function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Git Shortcuts
function gs { git status }

function ga { git add . }

function gc { param($m) git commit -m "$m" }

function gcl { git clone "$args" }

function gp { git push }

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

# Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Networking Utilities
function flushdns { Clear-DnsClientCache }

# Clipboard Utilities
function cpy { Set-Clipboard $args[0] }

function pst { Get-Clipboard }

Function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip ).Content }

function Get-HWVersion($computer, $name) {

     $pingresult = Get-WmiObject win32_pingstatus -f "address='$computer'"
     if($pingresult.statuscode -ne 0) { return }

     Get-WmiObject -Query "SELECT * FROM Win32_PnPSignedDriver WHERE DeviceName LIKE '%$name%'" -ComputerName $computer | 
           Sort DeviceName | 
           Select @{Name="Server";Expression={$_.__Server}}, DeviceName, @{Name="DriverDate";Expression={[System.Management.ManagementDateTimeconverter]::ToDateTime($_.DriverDate).ToString("MM/dd/yyyy")}}, DriverVersion
}

function Edit-Profile { notepad++ "$Env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }

function reload-profile { & $profile }

function Set-Home {
    [CmdletBinding()]
    [Alias("root")]
    param (
      # This function does not accept any parameters
    )
    Set-Location -Path $HOME
  }

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

function cleaner{	
	# Function to clean temporary files
	function Clean-TempFiles {
		Write-Host "Cleaning temporary files..."
		Get-ChildItem -Path $env:TEMP -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
	}

	# Function to clean the Recycle Bin
	function Clean-RecycleBin {
		Write-Host "Emptying the Recycle Bin..."
		(New-Object -ComObject Shell.Application).NameSpace(0xA).Items() | ForEach { Remove-Item $_.Path -Force -Recurse -ErrorAction SilentlyContinue }
	}

	# Function to perform disk cleanup
	function Perform-DiskCleanup {
		Write-Host "Performing disk cleanup..."
		$cleanmgr = Start-Process cleanmgr -ArgumentList "/sagerun:1" -PassThru
		$cleanmgr.WaitForExit()
	}	

	# Running all clean-up tasks
	Clean-TempFiles
	Clean-RecycleBin
	Perform-DiskCleanup

	Write-Host "System cleanup complete."
}

function ConvertTo-PrefixLength {
    param (
        [string]$SubnetMask
    )
    $binaryMask = $SubnetMask -split "\." | ForEach-Object {
        [convert]::ToString($_, 2).PadLeft(8, '0')
    }
    $binaryString = $binaryMask -join ''
    $prefixLength = ($binaryString.ToCharArray() | Where-Object { $_ -eq '1' }).Count
    return $prefixLength
}

function ipchangefun{
# Display network adapters to the user
Write-Host "Available Network Adapters and their Interface Indexes:"
Get-NetAdapter | Format-Table Name, InterfaceIndex, Status

# Prompt for Interface Index and validate
$interfaceIndex = $null
do {
    $interfaceIndex = Read-Host "Enter the Interface Index from the list above"
    if (-not $interfaceIndex -or $interfaceIndex -eq '') {
        Write-Host "Interface Index cannot be empty, please enter a valid number."
    }
    if (-not (Get-NetAdapter | Where-Object InterfaceIndex -eq $interfaceIndex)) {
        Write-Host "Invalid Interface Index entered. Please enter a number from the list above."
        $interfaceIndex = $null
    }
} while (-not $interfaceIndex)

$ipAddress = Read-Host "Enter the new IP Address"
$subnetMask = Read-Host "Enter the Subnet Mask"

# Check if subnet mask is empty and set default value
if ([string]::IsNullOrWhiteSpace($subnetMask)) {
    $subnetMask = "255.255.255.0"
}

# Convert the subnet mask to prefix length
$prefixLength = ConvertTo-PrefixLength -SubnetMask $subnetMask

# Remove the existing IP address
try {
    Get-NetIPAddress -InterfaceIndex $interfaceIndex | Remove-NetIPAddress -Confirm:$false
    Write-Host "Existing IP Address(es) removed."
} catch {
    Write-Error "Failed to remove existing IP Address. Error: $_"
}

# Set the IP Address
try {
    New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ipAddress -PrefixLength $prefixLength
    Write-Host "IP Address has been changed successfully."
} catch {
    Write-Error "Failed to change IP Address. Error: $_"
}
}

# call ps1 scripts
function pcdata {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/hw.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function windef {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/windefender.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}
function wea2 {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/weather-report.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function smart {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/query-smart-data.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function qr {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/qr.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function wea3 {
    # Assuming the script is accessible via the URL
    $scriptPath = "https://raw.githubusercontent.com/tejasholla/powershell-profile/main/Scripts/list-weather.ps1"
    $scriptContent = Invoke-RestMethod -Uri $scriptPath
    Invoke-Expression $scriptContent
}

function timezone {
    try {
        [system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
        Get-Timezone 
        exit 0 # success
    } catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
    }
}

function Theme-Check {
    if (Test-Path -Path $PROFILE.CurrentUserAllHosts -PathType leaf) {
        $existingTheme = Select-String -Raw -Path $PROFILE.CurrentUserAllHosts -Pattern "oh-my-posh init pwsh --config"
        if ($existingTheme -ne $null) {
            Invoke-Expression $existingTheme
            return
        }
    } else {
        oh-my-posh init pwsh --config https://raw.githubusercontent.com/tejasholla/powershell-profile/main/custommade.omp.json | Invoke-Expression
    }
}
Theme-Check

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
} else {
    Write-Host "zoxide command not found. Attempting to install via winget..."
    try {
        winget install -e --id ajeetdsouza.zoxide
        Write-Host "zoxide installed successfully. Initializing..."
        Invoke-Expression (& { (zoxide init powershell | Out-String) })
    } catch {
        Write-Error "Failed to install zoxide. Error: $_"
    }
}
