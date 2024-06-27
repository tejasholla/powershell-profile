# Configure Maximum Password Age in Windows
net.exe accounts /maxpwage:UNLIMITED

# Allow Execution of PowerShell Script Files
Set-ExecutionPolicy -Scope 'LocalMachine' -ExecutionPolicy 'RemoteSigned' -Force

# Groups or splits svchost.exe processes based on the amount of physical memory in the system to optimize performance
$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

$autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
    Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
}
$icaclsCommand = "icacls `"$autoLoggerDir`" /deny SYSTEM:`"(OI)(CI)F`""
Invoke-Expression $icaclsCommand | Out-Null

# Disable Defender Auto Sample Submission
Set-MpPreference -SubmitSamplesConsent 2 -ErrorAction Continue | Out-Null
 
# Removes Microsoft Teams
$TeamsPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, 'Microsoft', 'Teams')
$TeamsUpdateExePath = [System.IO.Path]::Combine($TeamsPath, 'Update.exe')

Stop-Process -Name "*teams*" -Force -ErrorAction Continue

if ([System.IO.File]::Exists($TeamsUpdateExePath)) {
    # Uninstall app
    $proc = Start-Process $TeamsUpdateExePath "-uninstall -s" -PassThru
    $proc.WaitForExit()
}

Get-AppxPackage "*Teams*" | Remove-AppxPackage -ErrorAction Continue
Get-AppxPackage "*Teams*" -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction Continue

if ([System.IO.Directory]::Exists($TeamsPath)) {
    Remove-Item $TeamsPath -Force -Recurse -ErrorAction Continue
}

# Uninstall from Uninstall registry key UninstallString
$us = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -like '*Teams*'}).UninstallString
if ($us.Length -gt 0) {
    $us = ($us.Replace('/I', '/uninstall ') + ' /quiet').Replace('  ', ' ')
    $FilePath = ($us.Substring(0, $us.IndexOf('.exe') + 4).Trim())
    $ProcessArgs = ($us.Substring($us.IndexOf('.exe') + 5).Trim().replace('  ', ' '))
    $proc = Start-Process -FilePath $FilePath -Args $ProcessArgs -PassThru
    $proc.WaitForExit()
}

# Disables Teredo
$registryKeysTeredo = @(
    @{Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"; Name = "DisabledComponents"; Type = "DWord"; Value = 1}
)
foreach ($key in $registryKeysTeredo) {
    New-ItemProperty -Path $key.Path -Name $key.Name -PropertyType $key.Type -Value $key.Value -Force
}
netsh interface teredo set state disabled

# Disables IPv6
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters' -Name 'DisabledComponents' -PropertyType 'DWord' -Value 255 -Force
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

# Disables Telemetry
# Disable Scheduled Tasks
$scheduledTasks = @(
    "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "Microsoft\Windows\Autochk\Proxy",
    "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
    "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
    "Microsoft\Windows\Feedback\Siuf\DmClient",
    "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
    "Microsoft\Windows\Windows Error Reporting\QueueReporting",
    "Microsoft\Windows\Application Experience\MareBackup",
    "Microsoft\Windows\Application Experience\StartupAppTask",
    "Microsoft\Windows\Application Experience\PcaPatchDbTask",
    "Microsoft\Windows\Maps\MapsUpdateTask"
)
foreach ($task in $scheduledTasks) {
    schtasks /Change /TN $task /Disable
}

# Enable the Ultimate Performance power plan
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

# Set the Ultimate Performance power plan as active
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# Set Services to Manual
Write-Output 'Set Services to Manual: Turns a bunch of system services to manual that do not need to be running all the time.'
Set-Service -Name 'AJRouter' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'ALG' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'AppIDSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'AppMgmt' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'AppReadiness' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'AppVClient' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'AppXSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Appinfo' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'AssignedAccessManagerSvc' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'AudioEndpointBuilder' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'AudioSrv' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'Audiosrv' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'AxInstSV' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BDESVC' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BFE' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'BITS' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BTAGService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BcastDVRUserService_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BrokerInfrastructure' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'Browser' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'BthAvctpSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'BthHFSrv' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'CDPSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'CDPUserSvc_*' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'COMSysApp' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'CaptureService_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'CertPropSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'ClipSVC' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'ConsentUxUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'CoreMessagingRegistrar' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'CredentialEnrollmentManagerUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'CryptSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'CscService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DPS' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'DcomLaunch' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'DcpSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DevQueryBroker' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DeviceAssociationBrokerSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DeviceAssociationService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DeviceInstall' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DevicePickerUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DevicesFlowUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Dhcp' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'DiagTrack' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'DialogBlockingService' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'DispBrokerDesktopSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'DisplayEnhancementService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DmEnrollmentSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Dnscache' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'DoSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DsSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DsmSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'DusmSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'EFS' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'EapHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'EntAppSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'EventLog' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'EventSystem' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'FDResPub' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Fax' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'FontCache' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'FrameServer' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'FrameServerMonitor' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'GraphicsPerfSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'HomeGroupListener' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'HomeGroupProvider' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'HvHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'IEEtwCollectorService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'IKEEXT' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'InstallService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'InventorySvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'IpxlatCfgSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'KeyIso' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'KtmRm' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'LSM' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'LanmanServer' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'LanmanWorkstation' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'LicenseManager' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'LxpSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MSDTC' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MSiSCSI' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MapsBroker' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'McpManagementService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MessagingService_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MicrosoftEdgeElevationService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MixedRealityOpenXRSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'MpsSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'MsKeyboardFilter' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NPSMSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NaturalAuthentication' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NcaSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NcbService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NcdAutoSetup' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NetSetupSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NetTcpPortSharing' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'Netlogon' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'Netman' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NgcCtnrSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NgcSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'NlaSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'OneSyncSvc_*' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'P9RdrService_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PNRPAutoReg' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PNRPsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PcaSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PeerDistSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PenService_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PerfHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PhoneSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PimIndexMaintenanceSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PlugPlay' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PolicyAgent' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Power' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'PrintNotify' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'PrintWorkflowUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'ProfSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'PushToInstall' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'QWAVE' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RasAuto' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RasMan' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RemoteAccess' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'RemoteRegistry' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'RetailDemo' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RmSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RpcEptMapper' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'RpcLocator' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'RpcSs' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SCPolicySvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SCardSvr' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SDRSVC' -StartupType Manual -ErrorAction Continue 
Set-Service -Name 'SEMgrSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SENS' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SNMPTRAP' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SNMPTrap' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SSDPSRV' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SamSs' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'ScDeviceEnum' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Schedule' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SecurityHealthService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Sense' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SensorDataService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SensorService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SensrSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SessionEnv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SgrmBroker' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SharedAccess' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SharedRealitySvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'ShellHWDetection' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SmsRouter' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Spooler' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SstpSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'StateRepository' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'StiSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'StorSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'SysMain' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'SystemEventsBroker' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'TabletInputService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TapiSrv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TermService' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'TextInputManagementService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Themes' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'TieringEngineService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TimeBroker' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TimeBrokerSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TokenBroker' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TrkWks' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'TroubleshootingSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'TrustedInstaller' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UI0Detect' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UdkUserSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UevAgentService' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'UmRdpService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UnistoreSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UserDataSvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'UserManager' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'UsoSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'VGAuthService' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'VMTools' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'VSS' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'VacSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'VaultSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'W32Time' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WEPHOSTSVC' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WFDSConMgrSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WMPNetworkSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WManSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WPDBusEnum' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WSService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WSearch' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WaaSMedicSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WalletService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WarpJITSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WbioSrvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Wcmsvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'WcsPlugInService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WdNisSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WdiServiceHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WdiSystemHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WebClient' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Wecsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WerSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WiaRpc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WinDefend' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'WinHttpAutoProxySvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WinRM' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'Winmgmt' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'WlanSvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'WpcMonSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WpnService' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'WpnUserService_*' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'WwanSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'XblAuthManager' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'XblGameSave' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'XboxGipSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'XboxNetApiSvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'autotimesvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'bthserv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'camsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'cbdhsvc_*' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'cloudidsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'dcsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'defragsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'diagnosticshub.standardcollector.service' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'diagsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'dmwappushservice' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'dot3svc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'edgeupdate' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'edgeupdatem' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'embeddedmode' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'fdPHost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'fhsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'gpsvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'hidserv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'icssvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'iphlpsvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'lfsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'lltdsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'lmhosts' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'mpssvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'msiserver' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'netprofm' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'nsi' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'p2pimsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'p2psvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'perceptionsimulation' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'pla' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'seclogon' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'shpamsvc' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'smphost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'spectrum' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'sppsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'ssh-agent' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'svsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'swprv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'tiledatamodelsvc' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'tzautoupdate' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'uhssvc' -StartupType Disabled -ErrorAction Continue
Set-Service -Name 'upnphost' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vds' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vm3dservice' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicguestinterface' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicheartbeat' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmickvpexchange' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicrdv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicshutdown' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmictimesync' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicvmsession' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmicvss' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'vmvss' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wbengine' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wcncsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'webthreatdefsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'webthreatdefusersvc_*' -StartupType Automatic -ErrorAction Continue
Set-Service -Name 'wercplsupport' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wisvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wlidsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wlpasvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wmiApSrv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'workfolderssvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wscsvc' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wuauserv' -StartupType Manual -ErrorAction Continue
Set-Service -Name 'wudfsvc' -StartupType Manual -ErrorAction Continue