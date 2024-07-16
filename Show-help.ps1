function Show-Help {
    param (
        [string]$Command = "all"
    )

    $helpText = @"
PowerShell Profile Help
=======================

1. Profile related
=======================
Update-Profile     - Checks for profile updates from a remote repository and updates if necessary.
Update-PowerShell  - Checks for the latest PowerShell release and updates if a new version is available.
Edit-Profile       - Opens the current user's profile for editing using the configured editor.
profile            - Opens the profile for editing.
reload             - Reloads the current user's PowerShell profile.
history            - Opens the history file of the commands saved.
exepolicy          - Runs the execution policy for the current user.

2. App related
=======================
npp                - Opens Notepad++ app [Ex: npp <filename>]
vi                 - Opens default editor here nvim [Ex: vi <filename>]
vim                - Opens default editor here nvim [Ex: vim <filename>]
nvim               - Opens default editor here nvim [Ex: nvim <filename>]
notes              - Creates a notes file [Ex: notes or npp notes]
ex                 - Opens Explorer app [This PC]
telegram           - Opens Telegram web
photos             - Opens Google Photos web
anydesk            - Opens Anydesk app
task               - Opens Task Manager app
cpl                - Opens Control Panel app

3. Download functions
=======================
ytdownload         - Runs a ytDownloader script to download YouTube videos and audios.
wallpaper          - Runs a script to download wallpapers.

4. Browser related
=======================
browser            - Opens default browser for searching.
edge               - Opens Edge browser for searching.
gs                 - Searches Google from Terminal [Ex: gs <search keyword>]
google             - Opens Google from default browser.
ys                 - Searches YouTube from Terminal [Ex: ys <search keyword>]
youtube            - Opens YouTube from default browser.
wiki               - Searches Wikipedia [Ex: wiki <search keyword>]
url                - Opens URLs [Ex: url <url link>]

5. Windows tools
=======================
windef             - Windows Defender scripts to scan.
logoff             - Logs off the current user.
reboot             - Restarts the computer after a 5-second delay.
halt               - Shuts down the computer after a 5-second delay.
lock               - Locks the workstation.
update             - Opens the Windows Update settings.

6. Enhanced Listing
=======================
la                 - Lists all files in the current directory with detailed formatting.
ll                 - Lists all files, including hidden, in the current directory with detailed formatting.
li                 - Lists all files.
lscheck            - Lists all files.
lsnu               - Lists all files with nu.
lscommand          - Gets commands with nu.

7. Git Shortcuts
=======================
github             - Opens GitHub web.
gitrepo            - Opens repository page directly.
gituser            - Enters GitHub username.
gitemail           - Enters GitHub email.
gitlist            - Lists GitHub config.
gst                - Shortcut for 'git status'.
ga                 - Shortcut for 'git add .'.
gadd               - git add command.
gc <message>       - Shortcut for 'git commit -m'.
clone              - Works as git clone the repo.
gp                 - Shortcut for 'git push'.
gi                 - git initiate.
gcom <message>     - Adds all changes and commits with the specified message.
lazyg <message>    - Adds all changes, commits with the specified message, and pushes to the remote repository.
graph              - Displays graph of commits.
ss                 - Shortcut for 'git status' but short.
nuke               - Deletes and resets the project.
g                  - Changes to the GitHub directory.

8. Quick Access to System Information
=======================
sysinfo            - Displays detailed system information.
pcdata             - Displays details of the PC.
powcheck           - Checks battery/power health.
batcheck           - Checks for battery report.
scanfile           - Shortcut for scannow.
checkhealth        - Checks health of the system.
scanhealth         - Scans health of the system.
restorehealth      - Restores health.
syshealthreport    - Generates system health report.

9. Networking Utilities
=======================
wifinetwork        - Displays all the WiFi passwords that were logged in.
thiswifi           - Displays current WiFi password.
wifi               - Displays specified WiFi password.
networkdetails     - Shows all network interfaces.
NetworkSpeed       - Displays network speed.
flushdns           - Clears the DNS cache.
Get-PubIP          - Retrieves the public IP address of the machine.
ipall              - Displays all IP configurations.
ipflush            - Clears the DNS cache.
online             - Checks if the client is online.
ipchange           - Script to change IP address.
iplocate           - Locates IP address.
hosts              - Opens host file.
ip                 - Command for IP configuration.

10. Clipboard Utilities
=======================
cpy <text>         - Copies the specified text to the clipboard.
pst                - Retrieves text from the clipboard.

11. File related
=======================
root               - Goes to the root directory.
cdc                - Opens C drive.
cdd                - Opens D drive.
cde                - Opens E drive.
cdf                - Opens F drive.
cdg                - Opens G drive.
docs               - Changes the current directory to the user's Documents folder.
dtop               - Changes the current directory to the user's Desktop folder.
head <path> [n]    - Displays the first n lines of a file (default 10).
tail <path> [n]    - Displays the last n lines of a file (default 10).
nf <name>          - Creates a new file with the specified name.
unzip <file>       - Extracts a zip file to the current directory.
grep <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.
df                 - Displays information about volumes.
sed <file> <find> <replace> - Replaces text in a file.
export <name> <value> - Sets an environment variable.
pkill <name>       - Kills processes by name.
pgrep <name>       - Lists processes by name.
touch <file>       - Creates a new empty file.
ff <name>          - Finds files recursively with the specified name.
mkdir <dir>        - Creates and changes to a new directory.
which <name>       - Shows the path of the command.
batchrename        - Helps to rename a bunch of files at a time.
organizer          - Organizes all the files present in the directory.

12. Location or map functions
=======================
loc                - Gives current location.
maps               - Opens from www.openstreetmap.org.
gmaps              - Gives direction in Google maps [Ex: gmaps <from> <to>].

13. Image compressor functions
=======================
imagecompress      - Compresses images with the help of www.iloveimg.com.
imgcomp            - Calls a script that can compress the images.

14. Recycle bin functions
=======================
binop              - Opens Recycle Bin.
binclean           - Cleans Recycle Bin.
cleanwin           - Cleans unwanted Windows files.

15. Weather functions
=======================
weatherfun         - Displays weather of current location.
weather            - Displays weather of current location.

16. Other functions
=======================
checkpass          - Checks the security status of the given password using haveibeenpwned.com.
timezone           - Displays the timezone of the current location.
qr                 - Generates a QR code for the specified URL [Ex: qr <url link>].
usb                - Enables or disables USB.
setup              - Runs the script for personalization of Windows Terminal.
shorturl           - Shortens long URLs.

17. WSL functions
=======================
reset-wsl          - Shuts down WSL.
linux              - Opens the default WSL distro.

18. Tweaks functions
=======================
wintweaks          - Some Windows tweaks.
debloat            - Runs the WinUtil script from Chris Titus Tech.
tweaks             - Some Windows tweaks.

19. AI run functions
=======================
chatgpt            - Opens the ChatGPT web.
chatty             - Opens webUI with ollama AI through WSL.

20. Utility functions
=======================
Get-Theme          - Updates theme of Oh My Posh.

=======================
Show-Help command
=======================
Use 'Show-Help all' to display all the commands.
Use 'Show-Help <command>' to display help for a particular command.
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

Write-Host "Use 'Show-Help all' to display all the commands."
Write-Host "Use 'Show-Help <command>' to display help for a particular command."