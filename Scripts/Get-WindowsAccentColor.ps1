function Get-WindowsAccentColor {
    $accentColor = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor"
    $accentColorHex = '{0:X}' -f $accentColor
    $accentColorHex = $accentColorHex.PadLeft(8, '0')
    return "#$($accentColorHex.Substring(2, 6))"
}

$accentColor = Get-WindowsAccentColor
Write-Output $accentColor
