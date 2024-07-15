function Show-Help {
    param (
        [string]$Command = "all"
    )

    $helpText = @"

PowerShell Profile Help
=======================

1. Profile related
=======================
Update-Profile - Checks for profile updates from a remote repository and updates if necessary.
Update-PowerShell - Checks for the latest PowerShell release and updates if a new version is available.
Edit-Profile - Opens the current user's profile for editing using the configured editor.
profile - Opens the profile for editing.
reload - Reloads the current user's PowerShell profile.
history - Opens history file of the commands saved
exepolicy - Run execution policy for current user

2. App related
=======================
npp - Opens Notepad ++ app [Ex: npp <filename>]
vi - opens default Editor here nvim [Ex: vi <filename>]
vim - opens default Editor here nvim [Ex: vim <filename>]
nvim - opens default Editor here nvim [Ex: nvim <filename>]
notes - creates a notes file where we can save [Ex: notes or npp notes]
ex - Opens explorer app [This PC]
telegram - Opens telegram web
photos - Opens Google Photos web
anydesk - Opens anydesk app
task - Opens task manager app
cpl - Opens Control Panel app

3. Download functions
=======================
ytdownload - Runs a ytDownloader script which downloads YouTube videos and audios
wallpaper - Runs a script which helps to download wallpapers

4. Browser related
=======================
browser - Opens default browser for searching
edge - Opens Edge browser for searching
gs - Search Google from Terminal [Ex: gs <search keyword>]
google - Open Google from Default browser
ys - Search YouTube from Terminal [Ex: ys <search keyword>]
youtube - Open YouTube from Default browser
wiki - Search for wiki [Ex: wiki <search keyword>] 
url - This helps to open urls [Ex: url <url link>]

5. windows tools
=======================
windef - Windows defender scripts helps to scan
logoff - Logoff the system
reboot - reboot the system
halt - shutdown the system

6. Enhanced Listing
=======================
la - Lists all files in the current directory with detailed formatting.
ll - Lists all files, including hidden, in the current directory with detailed formatting.
li - Lists all files
lscheck -Lists all files
lsnu - Lists all files with nu
lscommand - get commands with nu

7. Git Shortcuts
=======================
github - Opens GitHub web
gitrepo - Opens repo page directly
gituser - enter GitHub username
gitemail - enter GitHub email
gitlist - lists GitHub config
gst - Shortcut for 'git status'.
ga - Shortcut for 'git add .'.
gadd - git add command
gc <message> - Shortcut for 'git commit -m'.
clone - works as git clone the repo
gp - Shortcut for 'git push'.
gi - git initiate
gcom <message> - Adds all changes and commits with the specified message.
lazyg <message> - Adds all changes, commits with the specified message, and pushes to the remote repository.
graph - Displays graph of commits
ss - Shortcut for 'git status' but short
nuke - It delete and reset the project
g - Changes to the GitHub directory.

8. Quick Access to System Information
=======================
sysinfo - Displays detailed system information.
pcdata
powcheck
batcheck
scanfile
checkhealth
scanhealth
restorehealth
syshealthreport

9. Networking Utilities
=======================
wifinetwork - displays all the wifi password which was logged in
thiswifi - displays current wifi password
wifi - displays specififed wifi password
networkdetails - Shows all network interfaces
NetworkSpeed - Displays network speed
flushdns - Clears the DNS cache.
Get-PubIP - Retrieves the public IP address of the machine.
ipall - command for displaying all Ipconfig
ipflush - Clears the DNS cache.
online - Check if the client is online
ipchange - Script to change IP address
iplocate - Locate IP address
hosts - Opens host file
ip - command for Ipconfig

10. Clipboard Utilities
=======================
cpy <text> - Copies the specified text to the clipboard.
pst - Retrieves text from the clipboard.

11. file related
=======================
root - Go to the root directory
cdc - Opens C drive
cdd - Opens D drive
cde - Opens E drive
cdf - Opens F drive
cdg - Opens G drive
docs - Changes the current directory to the user's Documents folder.
dtop - Changes the current directory to the user's Desktop folder.
head <path> [n] - Displays the first n lines of a file (default 10).
tail <path> [n] - Displays the last n lines of a file (default 10).
nf <name> - Creates a new file with the specified name.
unzip <file> - Extracts a zip file to the current directory.
grep <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.
df - Displays information about volumes.
sed <file> <find> <replace> - Replaces text in a file.
export <name> <value> - Sets an environment variable.
pkill <name> - Kills processes by name.
pgrep <name> - Lists processes by name.
touch <file> - Creates a new empty file.
ff <name> - Finds files recursively with the specified name.
mkdir <dir> - Creates and changes to a new directory.
which <name> - Shows the path of the command.
batchrename - Helps to rename bunch of files at a time
organizer - It organizes all the files present in 

12. Location or map functions
=======================
loc - Gives current location
maps - Opens from www.openstreetmap.org
gmaps - Gives direction in Google maps [Ex: gmaps <from> <to>]

13. Image compressor functions
=======================
imagecompress - compress with the help of www.iloveimg.com
imgcomp - this calls a script that can compress the images

14. Recycle bin functions
=======================
binop - Opens Recycle Bin
binclean - clean Recycle Bin
cleanwin - Cleans windows unwanted files

15. weather function
=======================
weatherfun - Display weather of current location
weather - Display weather of current location

16. other functions
=======================
checkpass - checks the security status of the given password by haveibeenpwned.com
timezone - Displays Timezone of the current location
qr - Generate QR for URL specified [Ex: url <url link>]
usb - Enable or Diable USB
setup - Runs the script for personalization of Windows Terminal 
shorturl - Shorten large Urls

17. WSL functions
=======================
reset-wsl - shutdown WSL 
linux - Opens WSL default distro

18. Tweaks functions
=======================
wintweaks - Some windows tweaks
debloat - Runs the WinUtil script from Chris Titus Tech.
tweaks - Some windows tweaks

19. AI run functions
=======================
chatgpt - Open the chatgpt web
chatty - Opens webUI with ollama AI through WSL

20. Utility functions
=======================
Get-Theme - Update theme of oh my posh

=======================
Show-Help command
=======================
Use 'Show-Help all' to display all the commands
Use 'Show-Help <command>' to display help for a particular command
"@

    if ($Command -eq "all") {
        Write-Host $helpText
    } else {
        $lines = $helpText -split "`n"
        foreach ($line in $lines) {
            if ($line -match "^$Command\s+-") {
                Write-Host $line
                return
            }
        }
        Write-Host "No help available for '$Command'"
    }
}

Write-Host "Use 'Show-Help all' to display all the commands"
Write-Host "Use 'Show-Help <command>' to display help for a particular command"
