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