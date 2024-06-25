Get-WindowsOptionalFeature -Online |
Where-Object -Property 'FeatureName' -In -Value @(
  'Microsoft-SnippingTool';
) | Disable-WindowsOptionalFeature -Online -Remove -NoRestart *&gt;&amp;1 &gt;&gt; "$env:TEMP\remove-features.log";