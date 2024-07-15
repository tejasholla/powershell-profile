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
profile - Opens profile folder
reload - Reloads the current user's PowerShell profile.
history - Opens history file of the commands saved
exepolicy - Run execution policy for current user

2. App related
=======================
npp
vi
vim
nvim
notes
ex
telegram
photos
anydesk
task
cpl

3. Download functions
=======================
touch <file> - Creates a new empty file.
ff <name> - Finds files recursively with the specified name.
Get-PubIP - Retrieves the public IP address of the machine.
debloat - Runs the WinUtil script from Chris Titus Tech.
unzip <file> - Extracts a zip file to the current directory.
grep <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.
df - Displays information about volumes.
sed <file> <find> <replace> - Replaces text in a file.
which <name> - Shows the path of the command.
export <name> <value> - Sets an environment variable.
pkill <name> - Kills processes by name.
pgrep <name> - Lists processes by name.
head <path> [n] - Displays the first n lines of a file (default 10).
tail <path> [n] - Displays the last n lines of a file (default 10).
nf <name> - Creates a new file with the specified name.
mkdir <dir> - Creates and changes to a new directory.
docs - Changes the current directory to the user's Documents folder.
dtop - Changes the current directory to the user's Desktop folder.
ep - Opens the profile for editing.
k9 <name> - Kills a process by name.
la - Lists all files in the current directory with detailed formatting.
ll - Lists all files, including hidden, in the current directory with detailed formatting.
gs - Shortcut for 'git status'.
ga - Shortcut for 'git add .'.
gc <message> - Shortcut for 'git commit -m'.
gp - Shortcut for 'git push'.
g - Changes to the GitHub directory.
gcom <message> - Adds all changes and commits with the specified message.
lazyg <message> - Adds all changes, commits with the specified message, and pushes to the remote repository.
sysinfo - Displays detailed system information.
flushdns - Clears the DNS cache.
cpy <text> - Copies the specified text to the clipboard.
pst - Retrieves text from the clipboard.

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
