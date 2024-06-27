:: |------------------------------------------------------------------|
:: |                                                                  |
:: |                          CURRENT USER                            |
:: |                                                                  |
:: |------------------------------------------------------------------|

:: Disabling the Delivery of Personalized or Suggested Content Like App Suggestions, Tips, and Advertisements in Windows
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OEMPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v IsMiEnabled /t REG_DWORD /d 0 /f
reg.exe delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f
reg.exe delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f

:: Removes Copilot
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce" /v "UninstallCopilot" /t REG_SZ /d "" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f

:: Removes Store Banner in Notepad
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /v ShowStoreBanner /t REG_DWORD /d 0 /f

:: Removes OneDrive
reg.exe delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f

:: Align the taskbar to the left on Windows 11
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f

:: Hides Search Icon on Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Start Menu Customizations 
:: Disables Recently Added Apps and Recommendations in the Start Menu
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f

:: Hides or Removes People from Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f

:: Hides Task View Button on Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

:: Hides and Removes News and Interests from PC and Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

:: Hides or Removes Notifications
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

:: Disables User Account Control
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v UserAccountControlSettings /t REG_DWORD /d 0 /f

:: Disables User Account Sync
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v SettingSyncEnabled /t REG_DWORD /d 0 /f

:: Disables Location Services
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v LocationServicesEnabled /t REG_DWORD /d 0 /f

:: Disables Input Personalization Settings
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f

:: Disables Automatic Feedback Sampling
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v AutoSample /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v ServiceEnabled /t REG_DWORD /d 0 /f

:: Disables Recent Documents Tracking
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f

:: Disable "Let websites provide locally relevant content by accessing my language list"
reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

:: Disables "Let Windows track app launches to improve Start and search results"
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

:: Disables Background Apps
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

:: Disables App Diagnostics
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppDiagnostics" /v AppDiagnosticsEnabled /t REG_DWORD /d 0 /f

:: Disables Delivery Optimization
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f

:: Disables Tablet Mode
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f

:: Disables Use Sign-In Info for User Account
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication" /v UseSignInInfo /t REG_DWORD /d 0 /f

:: Disables Maps Auto Download
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Maps" /v AutoDownload /t REG_DWORD /d 0 /f

:: Disables Telemetry and Ads
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f

:: Manages and displays the status of ongoing operations, such as file copy, move, delete, etc.
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f

:: Set File Explorer to Open This PC instead of Quick Access
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: Set Display for Performance
reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f

:: On Shutdown, Windows will automatically close any running applications
reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f

:: Sets the Mouse hover time to 400 milliseconds
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f

:: Hides the Meet Now Button on the Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f

:: Disables the Second Out-Of-Box Experience
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f

:: Set Display for Performance
reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f

:: Set Registry Keys to Enable End Task With Right Click
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDeveloperSettings /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 1 /f

:: Disables Notification Tray and Calendar
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

:: Set Classic Right-Click Menu for Windows 11
reg.exe add "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f

:: Disable Xbox GameDVR
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f

:: Disables Bing Search in Start Menu
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

:: Enables NumLock on Startup
reg.exe add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f

:: Disables Mouse Acceleration
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f

:: Disables Sticky Keys
reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f
reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v HotkeyFlags /t REG_SZ /d "58" /f

:: Disables Snap Assist Flyout
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 0 /f

:: Enables Show File Extensions
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

:: Enables Dark Mode
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 0 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

:: Hides the Language Switcher on the Taskbar
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\LangBar" /v ShowStatus /t REG_DWORD /d 3 /f

:: WINDOWS 10 TASKBAR CUSTOMIZATIONS
:: Makes Taskbar Transparent in Windows 10
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAcrylicOpacity" /t REG_DWORD /d 0 /f
:: Makes Taskbar Small in Windows 10
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d 1 /f

:: Don't Update Last Access Time Stamp - This Can Improve File System Performance
fsutil.exe behavior set disableLastAccess 1

:: Restore Windows Photo Viewer & Set as Default Program for Image Files
:: Restore Windows Photo Viewer
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.bmp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.cr2" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.dib" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.gif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.ico" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.jfif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.jpe" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.jpeg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.jpg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.jxr" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.png" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.tif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.tiff" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\.wdp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
:: Create Relevant File Associations
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
:: Set Windows Photo Viewer as the default program for the specified file types
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f

:: |------------------------------------------------------------------|
:: |                                                                  |
:: |                          DEFAULT USER                            |
:: |                                                                  |
:: |------------------------------------------------------------------|

:: Disabling the Delivery of Personalized or Suggested Content Like App Suggestions, Tips, and Advertisements in Windows
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OEMPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
reg.exe delete "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f
reg.exe delete "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v IsMiEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f

:: Removes Copilot
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Runonce" /v "UninstallCopilot" /t REG_SZ /d "" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f

:: Removes Store Banner in Notepad
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Notepad" /v ShowStoreBanner /t REG_DWORD /d 0 /f

:: Removes OneDrive
reg.exe delete "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f

:: Align the taskbar to the left on Windows 11
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f

:: Hides Search Icon on Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Start Menu Customizations
:: Disables Recently Added Apps and Recommendations in the Start Menu
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f

:: Hides or Removes People from Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f

:: Hides Task View Button on Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

:: Hides and Removes News and Interests from PC and Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

:: Hides or Removes Notifications
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

:: Disables User Account Control
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v UserAccountControlSettings /t REG_DWORD /d 0 /f

:: Disables User Account Sync
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v SettingSyncEnabled /t REG_DWORD /d 0 /f

:: Disables Location Services
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v LocationServicesEnabled /t REG_DWORD /d 0 /f

:: Disables Input Personalization Settings
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f

:: Disables Automatic Feedback Sampling
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v AutoSample /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Feedback" /v ServiceEnabled /t REG_DWORD /d 0 /f

:: Disables Recent Documents Tracking
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f

:: Disables Background Apps
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

:: Disable "Let websites provide locally relevant content by accessing my language list"
reg.exe add "HKU\DefaultUser\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

:: Disables "Let Windows track app launches to improve Start and search results"
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

:: Disables App Diagnostics
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\AppDiagnostics" /v AppDiagnosticsEnabled /t REG_DWORD /d 0 /f

:: Disables Delivery Optimization
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f

:: Disables Tablet Mode
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f

:: Disables Use Sign-In Info for User Account
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication" /v UseSignInInfo /t REG_DWORD /d 0 /f

:: Disables Maps Auto Download
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Maps" /v AutoDownload /t REG_DWORD /d 0 /f

:: Disables Telemetry and Ads
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f

:: Manages and displays the status of ongoing operations, such as file copy, move, delete, etc.
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f

:: Set File Explorer to Open This PC instead of Quick Access
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f

:: Set Display for Performance
reg.exe add "HKU\DefaultUser\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f

:: On Shutdown, Windows will automatically close any running applications
reg.exe add "HKU\DefaultUser\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f

:: Sets the Mouse hover time to 400 milliseconds
reg.exe add "HKU\DefaultUser\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f

:: Hides the Meet Now Button on the Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f

:: Disables the Second Out-Of-Box Experience
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f

:: Set Display for Performance
reg.exe add "HKU\DefaultUser\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg.exe add "HKU\DefaultUser\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg.exe add "HKU\DefaultUser\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg.exe add "HKU\DefaultUser\Control Panel\Keyboard" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f

:: Set Registry Keys to Enable End Task With Right Click
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDeveloperSettings /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarEndTask /t REG_DWORD /d 1 /f

:: Disables Notification Tray and Calendar
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

:: Set Classic Right-Click Menu for Windows 11
reg.exe add "HKU\DefaultUser\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f

:: Disable Xbox GameDVR
reg.exe add "HKU\DefaultUser\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f
reg.exe add "HKU\DefaultUser\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f

:: Disables Bing Search in Start Menu
reg.exe add "HKU\DefaultUser\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

:: Enables NumLock on Startup
reg.exe add "HKU\DefaultUser\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f

:: Disables Mouse Acceleration
reg.exe add "HKU\DefaultUser\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg.exe add "HKU\DefaultUser\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg.exe add "HKU\DefaultUser\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f

:: Disables Sticky Keys
reg.exe add "HKU\DefaultUser\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f
reg.exe add "HKU\DefaultUser\Control Panel\Accessibility\StickyKeys" /v HotkeyFlags /t REG_SZ /d "58" /f

:: Disables Snap Assist Flyout
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 0 /f

:: Enables Show File Extensions
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

:: Enables Dark Mode
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 0 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

:: Hides the Language Switcher on the Taskbar
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\CTF\LangBar" /v ShowStatus /t REG_DWORD /d 3 /f 

:: WINDOWS 10 TASKBAR CUSTOMIZATIONS
:: Makes Taskbar Transparent in Windows 10
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAcrylicOpacity" /t REG_DWORD /d 0 /f
:: Makes Taskbar Small in Windows 10
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d 1 /f

:: Restore Windows Photo Viewer & Set as Default Program for Image Files
:: Restore Windows Photo Viewer
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.bmp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.cr2" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.dib" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.gif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.ico" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.jfif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.jpe" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.jpeg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.jpg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.jxr" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.png" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.tif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.tiff" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Classes\.wdp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
:: Create Relevant File Associations
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\OpenWithProgids" /v "PhotoViewer.FileAssoc.Tiff" /t REG_NONE /f
:: Set Windows Photo Viewer as the default program for the specified file types
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bmp\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cr2\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dib\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jfif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpe\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpeg\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jpg\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jxr\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.png\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tif\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.tiff\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.wdp\UserChoice" /v "ProgId" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f

:: |------------------------------------------------------------------|
:: |                                                                  |
:: |                          LOCAL MACHINE                           |
:: |                                                                  |
:: |------------------------------------------------------------------|

:: Bypasses Microsoft Account Creation
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v BypassNRO /t REG_DWORD /d 1 /f

:: Disables User Account Control
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Disable Windows Spotlight and set the normal Windows Picture as the desktop background
:: Disable Windows Spotlight on the lock screen
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnLockScreen /t REG_DWORD /d 1 /f
:: Disable Windows Spotlight suggestions, tips, tricks, and more on the lock screen
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
:: Disable Windows Spotlight on Settings
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightActiveUser /t REG_DWORD /d 1 /f
:: Set desktop background to a normal Windows picture
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f
:: Ensure the wallpaper style is set to fill (2 is for fill, 10 is for fit)
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v WallpaperStyle /t REG_SZ /d "2" /f

:: Prevents Dev Home Installation
reg.exe delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\DevHomeUpdate" /f

:: Prevents New Outlook for Windows Installation
reg.exe delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate" /f

:: Prevents Chat Auto Installation & Removes Chat Icon
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v ConfigureChatAutoInstall /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /t REG_DWORD /d 3 /f

:: Start Menu Customization
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins /t REG_SZ /d "{ \"pinnedList\": [] }" /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins_ProviderSet /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins_WinningProvider /t REG_SZ /d B5292708-1619-419B-9923-E5D9F3925E71 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" /v ConfigureStartPins /t REG_SZ /d "{ \"pinnedList\": [] }" /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" /v ConfigureStartPins_LastWrite /t REG_DWORD /d 1 /f
:: Enables the "Settings" and "File Explorer" Icon in the Start Menu
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings_ProviderSet /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderFileExplorer /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderFileExplorer_ProviderSet /t REG_DWORD /d 00000001 /f

:: Enable Long File Paths with Up to 32,767 Characters
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f

:: Disables News and Interests
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f

:: Disables Windows Consumer Features Like App Promotions etc.
reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f

:: Disables Bitlocker Auto Encryption on Windows 11 24H2 and Onwards
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\BitLocker" /v "PreventDeviceEncryption" /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /v TCGSecurityActivationDisabled /t REG_DWORD /d 1 /f

:: Sets Windows Update to Only Install Security Updates and Delay Other Updates for 2 Years
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 3 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 730 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 730 /f

:: Disables Cortana
reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Disables Activity History
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f

:: Disables Hibernation
reg.exe add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v ShowHibernateOption /t REG_DWORD /d 0 /f

:: Disables Location Tracking
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v Status /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SYSTEM\Maps" /v AutoUpdateEnabled /t REG_DWORD /d 0 /f

:: Disables Telemetry
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: Disables Windows Ink Workspace
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v AllowWindowsInkWorkspace /t REG_DWORD /d 0 /f

:: Disables Feedback Notifications
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f

:: Disables the Advertising ID for All Users
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f

:: Disables Windows Error Reporting
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

:: Disables Delivery Optimization
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f

:: Disables Remote Assistance
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

:: Search Windows Update for Drivers First
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f

:: Gives Multimedia Applications like Games and Video Editing a Higher Priority
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f

:: Controls whether the memory page file is cleared at shutdown. Value 0 means it will not be cleared, speeding up shutdown. 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f

:: Enables NDU (Network Diagnostic Usage) Service on Startup
reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f

:: Increases IRP stack size to 30 for the LanmanServer service to Improve Network Performance and Stability
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f

:: Hides the Meet Now Button on the Taskbar
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f

:: Gives Graphics Cards a Higher Priority for Gaming
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f

:: Gives the CPU a Higher Priority for Gaming
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f

:: Gives Games a higher priority in the system's scheduling
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f

:: Fix Managed by your organization in Edge
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /f

:: Set Registry Keys to Disable Wifi-Sense
reg.exe add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v Value /t REG_DWORD /d 0 /f
reg.exe add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v Value /t REG_DWORD /d 0 /f

:: Disables Storage Sense
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f

:: Disable Xbox GameDVR
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f

:: Disable Tablet Mode
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f

:: Always go to desktop mode on sign-in
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 1 /f

:: Disable "Use my sign-in info to automatically finish setting up my device after an update or restart"
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableAutomaticRestartSignOn /t REG_DWORD /d 1 /f

:: Disables OneDrive Automatic Backups of Important Folders (Documents, Pictures etc.)
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v KFMBlockOptIn /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f

:: Disables the "Push To Install" feature in Windows
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d 1 /f

:: Disables Consumer Account State Content
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerAccountStateContent" /t REG_DWORD /d 1 /f

:: Disables Cloud Optimized Content
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d 1 /f

:: Deletes Microsoft Edge Registry Entries
reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /f
reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications\Microsoft.MicrosoftEdge.Stable_124.0.2478.105_neutral__8wekyb3d8bbwe" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\Microsoft.MicrosoftEdgeDevToolsClient_10.0.19041.1023_neutral__8wekyb3d8bbwe" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdge.Stable_124.0.2478.105_neutral__8wekyb3d8bbwe" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\S-1-5-21-2466455740-832722602-188176761-1001\Microsoft.MicrosoftEdgeDevToolsClient_10.0.19041.1023_neutral__8wekyb3d8bbwe" /f

:: DELETES SCHEDULED TASKS REGISTRY KEYS
:: Deleting Application Compatibility Appraiser
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0600DD45-FAF2-4131-A006-0B17509B9F78}" /f
:: Deleting Customer Experience Improvement Program
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{4738DE7A-BCC1-4E2D-B1B0-CADB044BFA81}" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{6FAC31FA-4A85-4E64-BFD5-2154FF4594B3}" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{FC931F16-B50A-472E-B061-B6F79A71EF59}" /f
:: Deleting Program Data Updater
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0671EB05-7D95-4153-A32B-1426B9FE61DB}" /f
:: Deleting autochk proxy
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{87BF85F4-2CE1-4160-96EA-52F554AA28A2}" /f
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{8A9C643C-3D74-4099-B6BD-9C6D170898B1}" /f
:: Deleting QueueReporting
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{E3176A65-4E44-4ED3-AA73-3283660ACB9C}" /f