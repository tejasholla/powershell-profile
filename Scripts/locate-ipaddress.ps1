param([string]$IPaddress= "")

try {
	if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter IP address to locate" }

	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddress"
	write-output $result
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
