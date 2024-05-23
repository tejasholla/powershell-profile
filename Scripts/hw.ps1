function Get-RAMType {
    param (
        [string]$Type
    )

    switch ($Type) {
        0 { return "Unknown" }
        2 { return "DRAM" }
        3 { return "Synchronous DRAM" }
        4 { return "Cache DRAM" }
        5 { return "EDO" }
        6 { return "EDRAM" }
        7 { return "VRAM" }
        8 { return "SRAM" }
        9 { return "RAM" }
        10 { return "ROM" }
        11 { return "Flash" }
        12 { return "EEPROM" }
        13 { return "FEPROM" }
        14 { return "EPROM" }
        15 { return "CDRAM" }
        16 { return "3DRAM" }
        17 { return "SDRAM" }
        18 { return "SGRAM" }
        19 { return "RDRAM" }
        20 { return "DDR" }
        21 { return "DDR2" }
        22 { return "DDR2 FB-DIMM" }
        24 { return "DDR3" }
        25 { return "FBD2" }
        26 { return "DDR4" }
        default { return "" }
    }
}

# System
$system = Get-CimInstance CIM_ComputerSystem
$os = Get-CimInstance CIM_OperatingSystem
Write-Host "System Health Report" -ForegroundColor Cyan -BackgroundColor DarkGray
"System:"
"- Name: $($system.Name)"
"- Manufacturer: $($system.Manufacturer)"
"- Model: $($system.Model)"
"- OS: $($os.Caption), Service Pack: $($os.ServicePackMajorVersion), Version: $($os.Version)"

# Motherboard
$board = Get-CimInstance -ClassName Win32_BaseBoard
Write-Host "Motherboard: $($board.Manufacturer) $($board.Product)" -ForegroundColor DarkCyan

# CPU
$cpus = Get-CimInstance CIM_Processor
Write-Host "CPU: "
$cpus | ForEach-Object {
    "- $_.Name (cores $($_.NumberOfCores)/$($_.NumberOfLogicalProcessors))" -ForegroundColor DarkCyan
}

# RAM
$rams = Get-CimInstance -ClassName Win32_PhysicalMemory
"RAM:"
$ramInfo = $rams | ForEach-Object {
    [PSCustomObject]@{
        Type = (Get-RAMType -Type $_.SMBIOSMemoryType)
        BankLabel = $_.BankLabel
        DeviceLocator = $_.DeviceLocator
        CapacityGiB = [math]::Round($_.Capacity / 1GB, 2)
    }
}
$ramInfo | Format-Table -AutoSize -Property Type, BankLabel, DeviceLocator, CapacityGiB -ForegroundColor DarkCyan

# GPU
$gpus = Get-CimInstance -ClassName Win32_VideoController
"GPU:"
$gpus | ForEach-Object {
    "- $_.Caption" -ForegroundColor DarkCyan
}

# Storage
$disks = Get-Disk
"Storage:"
$disks | ForEach-Object {
    "- $_.FriendlyName ($([math]::Round($_.Size / 1GB, 2)) GiB)" -ForegroundColor DarkCyan
}

# Volumes
"Volumes:"
$volumes = Get-Volume
$volumes | ForEach-Object {
    "- Volume ($($_.FileSystemLabel)):"
    if ($_.DriveLetter) {
        "  - DriveLetter: $($_.DriveLetter)"
    }
    "  - Capacity: $([math]::Round($_.Size / 1GB, 2)) GiB"
    "  - Free Space: $([math]::Round($_.SizeRemaining / $_.Size, 2) * 100)% ($([math]::Round($_.SizeRemaining / 1GB, 2)) GiB)"
}

# Firewall status for all profiles (Domain, Private, Public)
$firewallStatus = Get-NetFirewallProfile | ForEach-Object {
    [PSCustomObject]@{
        Profile = $_.Name
        Enabled = $_.Enabled
    }
}
Write-Host "Firewall:"
$firewallStatus | Format-Table -Property Profile, Enabled -AutoSize -ForegroundColor DarkCyan

# Antivirus status
$antivirusStatus = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select-Object DisplayName, ProductState
Write-Host "Antivirus:"
$antivirusStatus | Format-Table -Property DisplayName, ProductState -AutoSize -ForegroundColor DarkCyan
