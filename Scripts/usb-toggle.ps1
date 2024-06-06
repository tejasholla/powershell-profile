# Prompt the user for confirmation
$response = Read-Host "For disable[1],enable[2]? "
if ($response -eq 1) {
    # Disable USB
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 4
    Write-Host "Disabled USB devices" -ForegroundColor DarkGray
}
elseif ($response -eq 2) {
    # Enable USB
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" -Name "Start" -Value 3
    Write-Host "Enabled USB devices" -ForegroundColor DarkGray
}
else {
    Write-Host "Invalid option" -ForegroundColor Red
}