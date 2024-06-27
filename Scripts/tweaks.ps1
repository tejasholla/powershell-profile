# |------------------------------------------------------------------|
# |                                                                  |
# |                          CURRENT USER                            |
# |                                                                  |
# |------------------------------------------------------------------|

# Disabling the Delivery of Personalized or Suggested Content Like App Suggestions, Tips, and Advertisements in Windows
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "FeatureManagementEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OEMPreInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContentEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "IsMiEnabled" -Type DWord -Value 0
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" -Recurse -Force
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" -Recurse -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Type DWord -Value 0

# Removes Copilot
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce" -Name "UninstallCopilot" -Type String -Value ""
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Type DWord -Value 1

# Removes Store Banner in Notepad
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Notepad" -Name "ShowStoreBanner" -Type DWord -Value 0

# Removes OneDrive
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup"

# Align the taskbar to the left on Windows 11
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Type DWord -Value 0

# Hides Search Icon on Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

# Start Menu Customizations 
# Disables Recently Added Apps and Recommendations in the Start Menu
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Type DWord -Value 0

# Hides or Removes People from Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0

# Hides Task View Button on Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

# Hides and Removes News and Interests from PC and Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0

# Hides or Removes Notifications
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

# Disables User Account Control
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "UserAccountControlSettings" -Type DWord -Value 0

# Disables User Account Sync
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "SettingSyncEnabled" -Type DWord -Value 0

# Disables Location Services
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "LocationServicesEnabled" -Type DWord -Value 0

# Disables Input Personalization Settings
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1

# Disables Automatic Feedback Sampling
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" -Name "AutoSample" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" -Name "ServiceEnabled" -Type DWord -Value 0

# Disables Recent Documents Tracking
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0

# Disable "Let websites provide locally relevant content by accessing my language list"
Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1

# Disables "Let Windows track app launches to improve Start and search results"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 0

# Disables Background Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

# Disables App Diagnostics
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppDiagnostics" -Name "AppDiagnosticsEnabled" -Type DWord -Value 0

# Disables Delivery Optimization
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 0

# Disables Tablet Mode
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "TabletMode" -Type DWord -Value 0

# Disables Use Sign-In Info for User Account
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication" -Name "UseSignInInfo" -Type DWord -Value 0

# Disables Maps Auto Download
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Maps" -Name "AutoDownload" -Type DWord -Value 0

# Disables Telemetry and Ads
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0

# Manages and displays the status of ongoing operations, such as file copy, move, delete, etc.
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

# Set File Explorer to Open This PC instead of Quick Access
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

# Set Display for Performance
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type DWord -Value 1

# On Shutdown, Windows will automatically close any running applications
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Type DWord -Value 1

# Sets the Mouse hover time to 400 milliseconds
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Type String -Value "400"

# Hides the Meet Now Button on the Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1

# Disables the Second Out-Of-Box Experience
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0

# Set Display for Performance
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0

# Set Registry Keys to Enable End Task With Right Click
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDeveloperSettings" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarEndTask" -Type DWord -Value 1

# Disables Notification Tray and Calendar
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

# Set Classic Right-Click Menu for Windows 11
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Type String -Value ""

# Disable Xbox GameDVR
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Type DWord -Value 2
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type DWord -Value 0

# Disables Bing Search in Start Menu
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type DWord -Value 1

# Enables NumLock on Startup
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type String -Value 2

# Disables Mouse Acceleration
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Type String -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Type String -Value "0"

# Disables Sticky Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "HotkeyFlags" -Type String -Value "58"

# Disables Snap Assist Flyout
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SnapAssist" -Type DWord -Value 0

# Enables Show File Extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Enables Dark Mode
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0

# Hides the Language Switcher on the Taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3

# WINDOWS 10 TASKBAR CUSTOMIZATIONS
# Makes Taskbar Transparent in Windows 10
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAcrylicOpacity" -Type DWord -Value 0
# Makes Taskbar Small in Windows 10
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Type DWord -Value 1

# Don't Update Last Access Time Stamp - This Can Improve File System Performance
fsutil.exe behavior set disableLastAccess 1

# Restore Windows Photo Viewer & Set as Default Program for Image Files
# Restore Windows Photo Viewer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.bmp" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.cr2" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.dib" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.gif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.ico" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.jfif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.jpe" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.jpeg" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.jpg" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.jxr" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.png" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.tif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.tiff" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Classes\.wdp" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"

# Create Relevant File Associations
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType String -Value ""

# Set Windows Photo Viewer as the default program for the specified file types
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"

# |------------------------------------------------------------------|
# |                                                                  |
# |                          DEFAULT USER                            |
# |                                                                  |
# |------------------------------------------------------------------|

# Disabling the Delivery of Personalized or Suggested Content Like App Suggestions, Tips, and Advertisements in Windows
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "FeatureManagementEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OEMPreInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenOverlayEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContentEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
Remove-Item -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" -Recurse -Force
Remove-Item -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" -Recurse -Force
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "IsMiEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Type DWord -Value 0

# Removes Copilot
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce" -Name "UninstallCopilot" -Type String -Value ""
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Type DWord -Value 1

# Removes Store Banner in Notepad
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Notepad" -Name "ShowStoreBanner" -Type DWord -Value 0

# Removes OneDrive
Remove-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" -Force

# Align the taskbar to the left on Windows 11
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Type DWord -Value 0

# Hides Search Icon on Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

# Start Menu Customizations
# Disables Recently Added Apps and Recommendations in the Start Menu
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Type DWord -Value 0

# Hides or Removes People from Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0

# Hides Task View Button on Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

# Hides and Removes News and Interests from PC and Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsEnabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0

# Hides or Removes Notifications
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

# Disables User Account Control
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "UserAccountControlSettings" -Type DWord -Value 0

# Disables User Account Sync
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "SettingSyncEnabled" -Type DWord -Value 0

# Disables Location Services
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "LocationServicesEnabled" -Type DWord -Value 0

# Disables Input Personalization Settings
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1

# Disables Automatic Feedback Sampling
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" -Name "AutoSample" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" -Name "ServiceEnabled" -Type DWord -Value 0

# Disables Recent Documents Tracking
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0

# Disables Background Apps
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

# Disable "Let websites provide locally relevant content by accessing my language list"
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1

# Disables "Let Windows track app launches to improve Start and search results"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 0

# Disables App Diagnostics
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\AppDiagnostics" -Name "AppDiagnosticsEnabled" -Type DWord -Value 0

# Disables Delivery Optimization
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 0

# Disables Tablet Mode
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "TabletMode" -Type DWord -Value 0

# Disables Use Sign-In Info for User Account
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication" -Name "UseSignInInfo" -Type DWord -Value 0

# Disables Maps Auto Download
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Maps" -Name "AutoDownload" -Type DWord -Value 0

# Disables Telemetry and Ads
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0

# Manages and displays the status of ongoing operations, such as file copy, move, delete, etc.
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

# Set File Explorer to Open This PC instead of Quick Access
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

# Set Display for Performance
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Desktop" -Name "MenuShowDelay" -Type DWord -Value 1

# On Shutdown, Windows will automatically close any running applications
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Desktop" -Name "AutoEndTasks" -Type DWord -Value 1

# Sets the Mouse hover time to 400 milliseconds
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Mouse" -Name "MouseHoverTime" -Type String -Value "400"

# Hides the Meet Now Button on the Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1

# Disables the Second Out-Of-Box Experience
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0

# Set Display for Performance
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0

# Set Registry Keys to Enable End Task With Right Click
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDeveloperSettings" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarEndTask" -Type DWord -Value 1

# Disables Notification Tray and Calendar
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

# Set Classic Right-Click Menu for Windows 11
New-Item -Path "HKU:\DefaultUser\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Type String -Value ""

# Disable Xbox GameDVR
Set-ItemProperty -Path "HKU:\DefaultUser\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Type DWord -Value 2
Set-ItemProperty -Path "HKU:\DefaultUser\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type DWord -Value 0

# Disables Bing Search in Start Menu
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type DWord -Value 1

# Enables NumLock on Startup
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type String -Value 2

# Disables Mouse Acceleration
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Mouse" -Name "MouseThreshold1" -Type String -Value "0"
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Mouse" -Name "MouseThreshold2" -Type String -Value "0"

# Disables Sticky Keys
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
Set-ItemProperty -Path "HKU:\DefaultUser\Control Panel\Accessibility\StickyKeys" -Name "HotkeyFlags" -Type String -Value "58"

# Disables Snap Assist Flyout
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SnapAssist" -Type DWord -Value 0

# Enables Show File Extensions
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

# Enables Dark Mode
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Type DWord -Value 0
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0

# Hides the Language Switcher on the Taskbar
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3

# WINDOWS 10 TASKBAR CUSTOMIZATIONS
# Makes Taskbar Transparent in Windows 10
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAcrylicOpacity" -Type DWord -Value 0
# Makes Taskbar Small in Windows 10
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Type DWord -Value 1

# Restore Windows Photo Viewer & Set as Default Program for Image Files
# Restore Windows Photo Viewer
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.bmp" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.cr2" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.dib" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.gif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.ico" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.jfif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.jpe" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.jpeg" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.jpg" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.jxr" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.png" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.tif" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.tiff" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Classes\.wdp" -Name "(default)" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
# Create Relevant File Associations
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
New-ItemProperty -Path "HKU:\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids" -Name "PhotoViewer.FileAssoc.Tiff" -PropertyType None -Force
# Set Windows Photo Viewer as the default program for the specified file types
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"
Set-ItemProperty -Path "HKU:\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\UserChoice" -Name "ProgId" -Type String -Value "PhotoViewer.FileAssoc.Tiff"

# |------------------------------------------------------------------|
# |                                                                  |
# |                          LOCAL MACHINE                           |
# |                                                                  |
# |------------------------------------------------------------------|

# Bypasses Microsoft Account Creation
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "BypassNRO" -PropertyType "DWord" -Value 1 -Force

# Disables User Account Control
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -PropertyType "DWord" -Value 0 -Force

# Disable Windows Spotlight and set the normal Windows Picture as the desktop background
# Disable Windows Spotlight on the lock screen
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightOnLockScreen" -PropertyType "DWord" -Value 1 -Force
# Disable Windows Spotlight suggestions, tips, tricks, and more on the lock screen
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType "DWord" -Value 1 -Force
# Disable Windows Spotlight on Settings
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightActiveUser" -PropertyType "DWord" -Value 1 -Force
# Set desktop background to a normal Windows picture
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "Wallpaper" -PropertyType "String" -Value "C:\Windows\Web\Wallpaper\Windows\img0.jpg" -Force
# Ensure the wallpaper style is set to fill (2 is for fill, 10 is for fit)
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "WallpaperStyle" -PropertyType "String" -Value "2" -Force

# Prevents Dev Home Installation
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe" -Name "DevHomeUpdate" -Force

# Prevents New Outlook for Windows Installation
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe" -Name "OutlookUpdate" -Force

# Prevents Chat Auto Installation & Removes Chat Icon
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" -Name "ConfigureChatAutoInstall" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -PropertyType "DWord" -Value 3 -Force

# Start Menu Customization
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins" -PropertyType "String" -Value '{ "pinnedList": [] }' -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_ProviderSet" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "ConfigureStartPins_WinningProvider" -PropertyType "String" -Value "B5292708-1619-419B-9923-E5D9F3925E71" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins" -PropertyType "String" -Value '{ "pinnedList": [] }' -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" -Name "ConfigureStartPins_LastWrite" -PropertyType "DWord" -Value 1 -Force
# Enables the "Settings" and "File Explorer" Icon in the Start Menu
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderSettings" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderSettings_ProviderSet" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderFileExplorer" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "AllowPinnedFolderFileExplorer_ProviderSet" -PropertyType "DWord" -Value 1 -Force

# Enable Long File Paths with Up to 32,767 Characters
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -PropertyType "DWord" -Value 1 -Force

# Disables News and Interests
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -PropertyType "DWord" -Value 0 -Force

# Disables Windows Consumer Features Like App Promotions etc.
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -PropertyType "DWord" -Value 0 -Force

# Disables Bitlocker Auto Encryption on Windows 11 24H2 and Onwards
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker" -Name "PreventDeviceEncryption" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" -Name "TCGSecurityActivationDisabled" -PropertyType "DWord" -Value 1 -Force

# Sets Windows Update to Only Install Security Updates and Delay Other Updates for 2 Years
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -PropertyType "DWord" -Value 3 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DeferFeatureUpdates" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DeferFeatureUpdatesPeriodInDays" -PropertyType "DWord" -Value 730 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DeferQualityUpdates" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DeferQualityUpdatesPeriodInDays" -PropertyType "DWord" -Value 730 -Force

# Disables Cortana
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -PropertyType "DWord" -Value 0 -Force

# Disables Activity History
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -PropertyType "DWord" -Value 0 -Force

# Disables Hibernation
New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -PropertyType "DWord" -Value 0 -Force

# Disables Location Tracking
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -PropertyType "String" -Value "Deny" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -PropertyType "DWord" -Value 0 -Force

# Disables Telemetry
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType "DWord" -Value 0 -Force

# Disables Windows Ink Workspace
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowWindowsInkWorkspace" -PropertyType "DWord" -Value 0 -Force

# Disables Feedback Notifications
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -PropertyType "DWord" -Value 1 -Force

# Disables the Advertising ID for All Users
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -PropertyType "DWord" -Value 1 -Force

# Disables Windows Error Reporting
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -PropertyType "DWord" -Value 1 -Force

# Disables Delivery Optimization
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -PropertyType "DWord" -Value 0 -Force

# Disables Remote Assistance
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -PropertyType "DWord" -Value 0 -Force

# Search Windows Update for Drivers First
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType "DWord" -Value 1 -Force

# Gives Multimedia Applications like Games and Video Editing a Higher Priority
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -PropertyType "DWord" -Value 4294967295 -Force

# Controls whether the memory page file is cleared at shutdown. Value 0 means it will not be cleared, speeding up shutdown.
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -PropertyType "DWord" -Value 0 -Force

# Enables NDU (Network Diagnostic Usage) Service on Startup
New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Ndu" -Name "Start" -PropertyType "DWord" -Value 2 -Force

# Increases IRP stack size to 30 for the LanmanServer service to Improve Network Performance and Stability
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -PropertyType "DWord" -Value 30 -Force

# Hides the Meet Now Button on the Taskbar
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -PropertyType "DWord" -Value 1 -Force

# Gives Graphics Cards a Higher Priority for Gaming
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -PropertyType "DWord" -Value 8 -Force

# Gives the CPU a Higher Priority for Gaming
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -PropertyType "DWord" -Value 6 -Force

# Gives Games a higher priority in the system's scheduling
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -PropertyType "String" -Value "High" -Force

# Fix Managed by your organization in Edge
Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -Force

# Set Registry Keys to Disable Wifi-Sense
New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -PropertyType "DWord" -Value 0 -Force
New-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -PropertyType "DWord" -Value 0 -Force

# Disables Storage Sense
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -PropertyType "DWord" -Value 0 -Force

# Disable Xbox GameDVR
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -PropertyType "DWord" -Value 0 -Force

# Disable Tablet Mode
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "TabletMode" -PropertyType "DWord" -Value 0 -Force

# Always go to desktop mode on sign-in
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" -Name "SignInMode" -PropertyType "DWord" -Value 1 -Force

# Disable "Use my sign-in info to automatically finish setting up my device after an update or restart"
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableAutomaticRestartSignOn" -PropertyType "DWord" -Value 1 -Force

# Disables OneDrive Automatic Backups of Important Folders (Documents, Pictures etc.)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive" -Name "KFMBlockOptIn" -PropertyType "DWord" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -PropertyType "DWord" -Value 1 -Force

# Disables the "Push To Install" feature in Windows
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PushToInstall" -Name "DisablePushToInstall" -PropertyType "DWord" -Value 1 -Force

# Disables Consumer Account State Content
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerAccountStateContent" -PropertyType "DWord" -Value 1 -Force

# Disables Cloud Optimized Content
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableCloudOptimizedContent" -PropertyType "DWord" -Value 1 -Force

# Deletes Microsoft Edge Registry Entries
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications\Microsoft.MicrosoftEdge.Stable_124.0.2478.105_neutral__8wekyb3d8bbwe" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\Microsoft.MicrosoftEdgeDevToolsClient_10.0.19041.1023_neutral__8wekyb3d8bbwe" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdge.Stable_124.0.2478.105_neutral__8wekyb3d8bbwe" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdgeDevToolsClient_10.0.19041.1023_neutral__8wekyb3d8bbwe" -Recurse -Force

# DELETES SCHEDULED TASKS REGISTRY KEYS
# Deleting Application Compatibility Appraiser
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0600DD45-FAF2-4131-A006-0B17509B9F78}" -Force
# Deleting Customer Experience Improvement Program
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{4738DE7A-BCC1-4E2D-B1B0-CADB044BFA81}" -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{6FAC31FA-4A85-4E64-BFD5-2154FF4594B3}" -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{FC931F16-B50A-472E-B061-B6F79A71EF59}" -Force
# Deleting Program Data Updater
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0671EB05-7D95-4153-A32B-1426B9FE61DB}" -Force
# Deleting autochk proxy
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{87BF85F4-2CE1-4160-96EA-52F554AA28A2}" -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{8A9C643C-3D74-4099-B6BD-9C6D170898B1}" -Force
# Deleting QueueReporting
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{E3176A65-4E44-4ED3-AA73-3283660ACB9C}" -Force

# |------------------------------------------------------------------|
# |                                                                  |
# |                          POWERSHELL HERE                         |
# |                                                                  |
# |------------------------------------------------------------------|

if (-not (Test-Path -Path Registry::HKEY_CLASSES_ROOT\.ps1)) {
	New-Item -Path Registry::HKEY_CLASSES_ROOT\.ps1 -Force
}

if (-not (Test-Path -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1)) {
	New-Item -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1 -Force
}
New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1 -Name EditFlags -Type DWord -Value 131072 -Force
New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1 -Name FriendlyTypeName -Type ExpandString -Value "@`"%systemroot%\system32\windowspowershell\v1.0\powershell.exe`",-103" -Force

if (-not (Test-Path -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\DefaultIcon)) {
	New-Item -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\DefaultIcon -Force
}
New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\DefaultIcon -Name "(Default)" -Type String -Value "`"C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe`",1" -Force

if (-not (Test-Path -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\RunAs\Command)) {
	New-Item -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\RunAs\Command -Force
}
New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\RunAs -Name HasLUAShield -Type String -Value "" -Force
New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\RunAs\Command -Name "(Default)" -Type String -Value "powershell.exe -NoExit -ExecutionPolicy Bypass -Command & '%1'"

# |------------------------------------------------------------------|
# |                                                                  |
# |                            WINTWEAKS                             |
# |                                                                  |
# |------------------------------------------------------------------|

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