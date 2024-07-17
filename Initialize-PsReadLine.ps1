# Set colors based on whether the session is running as administrator
if ($isAdmin) {
    Set-PSReadLineOption -Colors @{
        Default            = '#98C379'
        Command            = '#f6de4b'
        Comment            = 'DarkCyan'
        ContinuationPrompt = '#56B6C2'
        Error              = '#E06C75'
        keyword            = '#C678DD'
        String             = 'DarkCyan'
        Number             = '#E5C07B'
        Member             = '#56B6C2'
        Operator           = 'Magenta'
        Type               = 'Cyan'
        Parameter          = 'Green'
        Variable           = 'Yellow'
        Emphasis           = '#98C379'
        InlinePrediction   = '#70A99F'
    }
} else {
    Set-PSReadLineOption -Colors @{
        Default            = '#98C379' # Light Green
        Command            = '#61AFEF' # Light Blue
        Comment            = '#abb2bf' # Light Gray
        ContinuationPrompt = '#56B6C2' # Cyan
        Error              = '#E06C75' # Light Red
        keyword            = '#C678DD' # Light Purple
        String             = '#e6a26f' # Light Orange
        Number             = '#E5C07B' # Light Yellow
        Member             = '#56B6C2' # Cyan
        Operator           = '#C678DD' # Light Purple
        Type               = '#98C379' # Light Green
        Parameter          = '#e6a26f' # Light Orange
        Variable           = '#E06C75' # Light Red
        Emphasis           = '#98C379' # Light Green
        InlinePrediction   = '#E5C07B' # Light Yellow
    }
}

# PSReadLine configuration
Set-PSReadLineOption -EditMode Emacs -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -MaximumHistoryCount 4096
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -HistorySearchCaseSensitive:$false
Set-PSReadLineOption -HistoryNoDuplicates:$true

# Custom key bindings
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine
Set-PSReadLineKeyHandler -Chord 'Alt+y' -Function YankLastArg
Set-PSReadLineKeyHandler -Chord "Ctrl+a" -Function SelectAll
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -Key 'Ctrl+l' -Function ClearScreen
Set-PSReadLineKeyHandler -Key 'Alt+e'  -BriefDescription "CWD" -LongDescription "Open the current working directory in the Windows Explorer" -ScriptBlock { Start-Process explorer -ArgumentList '.' }

# Set cursor to the start of the line
Set-PSReadLineKeyHandler -Key "Ctrl+UpArrow" -BriefDescription GoToBegin -LongDescription "Set cursor to the start of the line" -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::SetCursorPosition(0)
}

# Set cursor to the end of the line
Set-PSReadLineKeyHandler -Key "Ctrl+DownArrow" -BriefDescription GoToEnd -LongDescription "Set cursor to the end of the line" -ScriptBlock {
    $string = $null
    $cursor = $null
    [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref] $string, [ref] $cursor)
    [Microsoft.Powershell.PSConsoleReadLine]::SetCursorPosition($string.Length)
}

# Abort current operation
Set-PSReadLineKeyHandler -Key "Ctrl+z" -BriefDescription Abort -LongDescription "Abort current operation" -ScriptBlock {
    [Microsoft.Powershell.PSConsoleReadLine]::CancelLine()
}

# Ctrl+X that either cuts selected text, cuts whole unselected line, or exits console
Set-PSReadLineKeyHandler -Key Ctrl+x -BriefDescription CutOrExit -LongDescription "Cuts selection, whole input or exits console" -ScriptBlock {
    $start = $null
    $length = $null
    $string = $null
    $cursor = $null

    [Microsoft.Powershell.PSConsoleReadLine]::GetSelectionState([ref] $start, [ref] $length)
    if ($length -gt 0) {
        switch ($PSVersionTable.Platform) {
            "" { [Microsoft.Powershell.PSConsoleReadLine]::Cut() }
            "Win32NT" { [Microsoft.Powershell.PSConsoleReadLine]::Cut() }
            "Unix" {
                [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref] $string, [ref] $cursor)
                [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
                $string.Substring($start, $length) | xsel --input -b
                [Microsoft.Powershell.PSConsoleReadLine]::Insert($string.Remove($start, $length))
            }
        }
        return
    }

    [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref] $string, [ref] $cursor)
    if ($string) {
        switch ($PSVersionTable.Platform) {
            "" { $string | clip }
            "Win32NT" { $string | clip }
            "Unix" { $string | xsel --input -b }
            default { return }
        }
        [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
        return
    }

    [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
    [Microsoft.Powershell.PSConsoleReadLine]::Insert("exit")
    [Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
}

# Determine if running on Unix-like platform
$IsUnix = $false
if ($PSVersionTable.Platform -eq "Unix") {
    $IsUnix = $true
}

# Set Unix-specific key bindings
if ($IsUnix) {
    Set-PSReadLineKeyHandler -Key Ctrl+c -BriefDescription CopyOrCancel -LongDescription "Copies selected text or does cancellation" -ScriptBlock {
        $start = $null
        $length = $null
        $string = $null
        $cursor = $null

        [Microsoft.Powershell.PSConsoleReadLine]::GetSelectionState([ref] $start, [ref] $length)

        if ($length -le 0) {
            [Microsoft.Powershell.PSConsoleReadLine]::CancelLine()
            return
        }

        [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref] $string, [ref] $cursor)
        $string.Substring($start, $length) | xsel --input -b
    }

    Set-PSReadLineKeyHandler -Key Ctrl+v -BriefDescription PasteFromClipboard -LongDescription "Paste text from clipboard" -ScriptBlock {
        $clipboard = xsel --output -b
        $clipboard = $clipboard -join [environment]::NewLine
        [Microsoft.Powershell.PSConsoleReadLine]::Insert($clipboard)
    }
}

# Save the current line in history but do not execute
Set-PSReadLineKeyHandler -Key Alt+w -BriefDescription SaveInHistory -LongDescription "Save current line in history but do not execute" -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null

    [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.Powershell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.Powershell.PSConsoleReadLine]::RevertLine()
}

# Replace aliases with the full command
Set-PSReadLineKeyHandler -Key "Alt+n" -BriefDescription ExpandAliases -LongDescription "Replace aliases with the full command" -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null

    [Microsoft.Powershell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $start = 0

    if ($tokens.Count -gt 0) {
        $start = $tokens[0].Extent.StartOffset
    }

    if ($tokens.Count -le 0) {
        return
    }

    $end = $tokens[$tokens.Count - 1].Extent.EndOffset
    $input = $ast.Extent.Text.Substring($start, $end - $start)

    $replaced = $tokens | % {
        $input = $input.Replace($_.Extent.Text, $_.ResolvedCommandName)
    }

    [Microsoft.Powershell.PSConsoleReadLine]::Insert("$input")
}

# Define a custom handler
function Show-Current-Command-Help {
    $buffer = [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState().CurrentBuffer
    $input = ($buffer -join "").Trim()

    if ($input) {
        Show-Help $input
        [Microsoft.PowerShell.PSConsoleReadLine]::ClearScreen()
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
}

# Set the key handler for Alt + k
Set-PSReadLineKeyHandler -Chord 'Alt+s' -ScriptBlock { Show-Current-Command-Help }
