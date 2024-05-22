# set PowerShell to UTF-8
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
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key Alt+e `
	-BriefDescription "CWD" `
	-LongDescription "Open the current working directory in the Windows Explorer" `
	-ScriptBlock { Start-Process explorer -ArgumentList '.' }

    Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
        }
    }
    
    Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
        param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
        }
    }
    
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
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin
Set-Alias li ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias ip ipconfig
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
set-Alias anydesk 'C:\Program Files (x86)\AnyDesk\AnyDesk.exe'
set-Alias task 'C:\WINDOWS\system32\Taskmgr.exe'
set-Alias cpl 'D:\apps\Control Panel.lnk'
set-Alias winutil 'D:\apps\WinUtil.lnk'
set-Alias nucommand 'D:\apps\nu_commands.txt'
Set-Alias nuopen nu
set-Alias chatgpt 'C:\Program Files\ChatGPT\ChatGPT.exe'
set-Alias github 'D:\apps\GitHub.lnk'
set-Alias cr 'D:\apps\Crunchyroll - Watch Popular Anime.lnk'

# Function definitions
function notepad++ { Start-Process -FilePath "C:\Program Files\Notepad++\Notepad++.exe" -ArgumentList $args }

function notes { notepad++ "$Env:USERPROFILE\Documents\Notes.txt" }

function browser {
    $path = Join-Path $env:USERPROFILE 'AppData\Local\Thorium\Application\thorium.exe'
    Start-Process $path
}

function chattyfun {
    start http://localhost:8080/
    
    # Open WSL in a new Windows Terminal tab
    Start-Process wt -ArgumentList @('-w', '0', 'nt', 'wsl')
}
# Set alias for the function
Set-Alias chatty chattyfun

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

function SystemResourceUsage {
    $cpuLoad = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty countersamples | Select-Object -ExpandProperty cookedvalue
    $memUsage = Get-WmiObject Win32_OperatingSystem | Select-Object @{Name="MemoryUsage";Expression={"{0:N2}" -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize)}}
    Write-Output "CPU Load: $cpuLoad%"
    Write-Output "Memory Usage: $($memUsage.MemoryUsage)%"
}

function EnvironmentHealthReport {
    # Check if running as Administrator
    if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "This script should be run as an Administrator for complete functionality." -ForegroundColor Yellow
    }
    else {
        # Operating system information
        $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
        # Disk health status
        $diskHealth = Get-CimInstance -ClassName Win32_DiskDrive | Select-Object Model, Status
        # Firewall status for all profiles (Domain, Private, Public)
        $firewallStatus = Get-NetFirewallProfile | ForEach-Object {
            [PSCustomObject]@{
                Profile = $_.Name
                Enabled = $_.Enabled
            }
        }
        # Antivirus status
        $antivirusStatus = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select-Object displayName, productState

        # Display Results
        Write-Host "System Health Report" -ForegroundColor Cyan -BackgroundColor DarkGray
        Write-Host "OS Information: $($osInfo.Caption), Version: $($osInfo.Version)" -ForegroundColor Green
        Write-Host "Disk Status:" -ForegroundColor Magenta
        $diskHealth | Format-Table -Property Model, Status -AutoSize
        Write-Host "Firewall Status:" -ForegroundColor Yellow
        $firewallStatus | Format-Table -Property Profile, Enabled -AutoSize
        Write-Host "Antivirus Status:" -ForegroundColor Blue
        $antivirusStatus | Format-Table -Property displayName, productState -AutoSize
    }
}

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

function uninstall{
	$app = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "$args"}
	$app.Uninstall()
}

function hideinimagefun{copy /b $image+$file $saveimage}
set-alias hideinimage hideinimagefun

function encrypt {
    param($path)
    cipher /E /A /I:$path
}

function wifinetwork{netsh wlan show profile}

function wifinetworkfun{netsh wlan show profile $args key=clear | findstr “Key Content”}
set-alias thiswifi wifinetworkfun

function expo{explorer .}

function weatherfun{curl wttr.in/$args}
set-alias weather weatherfun

function qrfun{curl qrenco.de/$args}
set-alias qr qrfun

function webFun{start $args}
set-alias web webFun

function hideFun{attrib +h +s +r $args}
set-alias hide hideFun

function unhideFun{attrib -h -s -r $args}
set-alias unhide unhideFun

function profilefun {
	$path = Join-Path $env:USERPROFILE 'Documents\PowerShell'
	Start-Process $path
}
set-alias profile profilefun

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

function tokeifun{tokei $args}
set-alias linedata tokeifun

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

function g { z Github }

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

function find-file($name) {
        Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
                $place_path = $_.directory
                Write-Output "${place_path}\${_}"
        }
}

function unzip ($file) {
        Write-Output("Extracting", $file, "to", $pwd)
	$fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
        Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function grep($regex, $dir) {
        if ( $dir ) {
                Get-ChildItem $dir | select-string $regex
                return
        }
        $input | select-string $regex
}

function touch($file) {
        "" | Out-File $file -Encoding ASCII
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

## Final Line to set prompt
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
