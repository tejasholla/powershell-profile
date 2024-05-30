function qrimage {
    param(
        [string]$Text = "",
        [string]$ImageSize = ""
    )

    try {
        if ($Text -eq "") { $Text = Read-Host "Enter text or URL" }
        if ($ImageSize -eq "") { $ImageSize = Read-Host "Enter image size (e.g. 500x500)" }

        $ECC = "M" # can be L, M, Q, H
        $QuietZone = 1
        $ForegroundColor = "000000"
        $BackgroundColor = "ffffff"
        $FileFormat = "jpg"

        if ($PSVersionTable.PSVersion.Platform -eq "Unix") {
            $PathToPics = "$HOME/Pictures"
        } else {
            $PathToPics = [Environment]::GetFolderPath('MyPictures')
        }

        if (-not (Test-Path -Path $PathToPics -PathType Container)) {
            throw "Pictures folder at 📂$PathToPics doesn't exist (yet)"
        }

        $NewFile = "$PathToPics/QR_code.jpg"

        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $Text + "&ecc=" + $ECC + `
            "&size=" + $ImageSize + "&qzone=" + $QuietZone + `
            "&color=" + $ForegroundColor + "&bgcolor=" + $BackgroundColor + `
            "&format=" + $FileFormat), $NewFile)

        "✔️ saved new QR code image file to: $NewFile"
    } catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    }
}