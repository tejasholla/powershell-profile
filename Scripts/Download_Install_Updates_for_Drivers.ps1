try {
    $Session  = New-Object -ComObject Microsoft.Update.Session
    $Searcher = $Session.CreateUpdateSearcher()

    # Ensure the service ID is correct
    $Searcher.ServiceID = "7971f918-a847-4430-9279-4a52d1efe18d"
    $Searcher.SearchScope = 1 # MachineOnly
    $Searcher.ServerSelection = 3 # Third Party

    Write-Verbose -Message "Searching Driver Updates..." -Verbose

    # Search for driver updates
    $SearchResult = $Searcher.Search("IsInstalled=0 and Type='Driver' and IsHidden=0")
    $Updates = $SearchResult.Updates

    # Show available drivers
    $Updates | Select-Object -Property Title, DriverModel, DriverVerDate, Driverclass, DriverManufacturer

    # Download the drivers from Microsoft
    $UpdatesToDownload = New-Object -Com Microsoft.Update.UpdateColl
    $Updates | ForEach-Object -Process {
        $UpdatesToDownload.Add($_) | Out-Null
    }

    Write-Verbose -Message "Downloading Drivers..." -Verbose

    $UpdateSession = New-Object -Com Microsoft.Update.Session
    $Downloader = $UpdateSession.CreateUpdateDownloader()
    $Downloader.Updates = $UpdatesToDownload
    $Downloader.Download()

    # Check if the drivers are all downloaded and trigger the installation
    $UpdatesToInstall = New-Object -Com Microsoft.Update.UpdateColl
    $Updates | ForEach-Object -Process {
        if ($_.IsDownloaded) {
            $UpdatesToInstall.Add($_) | Out-Null
        }
    }

    Write-Verbose -Message "Installing Drivers..." -Verbose

    $Installer = $UpdateSession.CreateUpdateInstaller()
    $Installer.Updates = $UpdatesToInstall
    $InstallationResult = $Installer.Install()

    if ($InstallationResult.RebootRequired) {
        Write-Verbose -Message "Reboot required" -Verbose
    } else {
        Write-Verbose -Message "Done" -Verbose
    }
} catch {
    Write-Error -Message "An error occurred: $_"
}
