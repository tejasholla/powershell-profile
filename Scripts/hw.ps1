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

function GetCPUTemperature {
	$temp = 99999.9 # unsupported
	if ($IsLinux) {
		if (Test-Path "/sys/class/thermal/thermal_zone0/temp" -pathType leaf) {
			[int]$IntTemp = Get-Content "/sys/class/thermal/thermal_zone0/temp"
			$temp = [math]::round($IntTemp / 1000.0, 1)
		}
	} else {
		$objects = Get-WmiObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
		foreach ($object in $objects) {
			$highPrec = $object.HighPrecisionTemperature
			$temp = [math]::round($highPrec / 100.0, 1)
		}
	}
	return $temp
}

#system
$system = Get-CimInstance CIM_ComputerSystem
$os = Get-CimInstance CIM_OperatingSystem
Write-Host "System Health Report" -ForegroundColor White -BackgroundColor DarkGray
Write-Host "System:" -ForegroundColor Yellow
Write-Host "- Name: " -NoNewline
Write-Host $system.Name -ForegroundColor Cyan
Write-Host "- Manufacturer: " -NoNewline
Write-Host $system.Manufacturer -ForegroundColor Cyan
Write-Host "- Model: " -NoNewline
Write-Host $system.Model -ForegroundColor Cyan
Write-Host "- OS: "-NoNewline
Write-Host "$($os.caption), Service Pack: $($os.ServicePackMajorVersion), Version: $($osInfo.Version)" -ForegroundColor Cyan

#motherboard
$board = Get-CimInstance -ClassName Win32_BaseBoard
Write-Host "Motherboard: " -NoNewline -ForegroundColor Yellow
Write-Host $board.Manufacturer $board.Product -ForegroundColor Cyan

#cpu
$cpus = Get-CimInstance CIM_Processor
Write-Host "CPU: " -NoNewline -ForegroundColor Yellow
$details = Get-WmiObject -Class Win32_Processor
$socket = "$($details.SocketDesignation) socket, "
$celsius = GetCPUTemperature
if ($celsius -eq 99999.9) {
	$temp = "no temp"
} elseif ($celsius -gt 50) {
	$temp = "$($celsius)°C"
	$status = "⚠️"
} elseif ($celsius -lt 0) {
	$temp = "$($celsius)°C"
	$status = "⚠️"
} else {
	$temp = "$($celsius)°C"
} 
foreach ($cpu in $cpus) {
	Write-Host $cpu.Name -NoNewline -ForegroundColor Cyan
	Write-Host " (cores $($cpu.NumberOfCores)/$($cpu.NumberOfLogicalProcessors))"
	Write-Host " $($socket)$temp"
}

#ram
$rams = Get-CimInstance -ClassName Win32_PhysicalMemory
Write-Host "RAM: " -ForegroundColor Yellow
"- Capacity: {0:N2} GiB" -f (($rams.Capacity | Measure-Object -Sum).Sum / 1GB)
"- Total Physical Memory: {0:N2} GiB" -f ($system.TotalPhysicalMemory / 1GB)
"- Memory modelus: "
foreach ($ram in $rams) {
	"  - $((Get-RAMType -Type $ram.SMBIOSMemoryType)) [$($ram.BankLabel)/$($ram.DeviceLocator)] ({0:N2} GiB)" -f ($ram.Capacity / 1GB)
}

#gpu
$gpus = Get-CimInstance -ClassName Win32_VideoController
Write-Host "GPU:" -ForegroundColor Yellow
foreach ($gpu in $gpus) {
	Write-Host "- " -NoNewline
	Write-Host $gpu.Caption -ForegroundColor Cyan
}

#storage
$disks = Get-Disk
Write-Host "Storage:" -ForegroundColor Yellow
foreach ($disk in $disks) {
	Write-Host "- " -NoNewline
	Write-Host $disk.FriendlyName -ForegroundColor Cyan -NoNewline
	" ({0:N2} GiB)" -f ($disk.Size / 1GB) 
}

#volumes
"- Volumes: "
$volumes = Get-Volume
foreach ($vol in $volumes) {
	"  - Volume ($($vol.FileSystemLabel)): "
	if (!($null -eq $vol.DriveLetter)) {
		"    - DriveLetter: $($vol.DriveLetter)"
	}

	"    - Capacity: {0:N2} GiB" -f ($vol.Size / 1GB)
	"    - Free Space: {0:P2} ({1:N2} GiB)" -f ($vol.SizeRemaining / $vol.Size), ($vol.SizeRemaining / 1GB)
}

# Firewall status for all profiles (Domain, Private, Public)
$firewallStatus = Get-NetFirewallProfile | ForEach-Object {
    [PSCustomObject]@{
        Profile = $_.Name
        Enabled = $_.Enabled
    }
}
Write-Host "Firewall: " -ForegroundColor Yellow
$firewallStatus | Format-Table -Property Profile, Enabled -AutoSize

# Antivirus status
$antivirusStatus = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select-Object displayName, productState
Write-Host "Antivirus: " -ForegroundColor Yellow
$antivirusStatus | Format-Table -Property displayName, productState -AutoSize 