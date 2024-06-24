[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [ValidateSet("isgd", "tinyurl")]
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
        $Shortener = Read-Host "Please enter the URL shortening service (isgd or tinyurl)"
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
        "isgd" { $BaseURL = "https://is.gd/create.php?format=simple&url=$Link" }
        "tinyurl" { $BaseURL = "http://tinyurl.com/api-create.php?url=$Link" }
        default {
            Write-Error -Message "Invalid URL shortener specified. Supported options are 'isgd','tinyurl'!"
            return
        }
    }

    if ($ValidUrl) {
        try {
            $Response = $WebClient.DownloadString($BaseURL)
            if ($null -eq $Response) {
                Write-Error -Message "Failed to shorten the URL. The response from the server was null."
                return
            }
            $ShortenedUrl = $Response.Trim()
            [PSCustomObject]@{
                OriginalURL      = $Link
                ShortenedURL     = $ShortenedUrl
                Shortener        = $Shortener
                CreationDateTime = Get-Date
            }
        }
        catch {
            Write-Error -Message "An error occurred while attempting to shorten the URL: $_"
        }
    }
}

END {
    if ($WebClient) {
        $WebClient.Dispose()
    }
}
