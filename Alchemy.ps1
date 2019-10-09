<#
    This one checks your current seed from the log for LCAP recipes using Zatherszszzs site.
    It will update on new game too.
#>
$ErrorActionPreference='silentlycontinue'
$gamepath = (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 881100").GetValue("InstallLocation")
if($gamepath -eq $null) {
	$gamepath = "."
}
$lastseed = 0
while($true) {
	$seed = Select-String -Path "$gamepath\logger.txt" -Pattern 'World seed: (.*)$' | foreach { $_.Matches.Groups[1].Value }
	if ($seed -and $seed -ne $lastseed) {
		$seed
		$lastseed = $seed
		$a = Invoke-WebRequest -Uri "http://94.172.33.134:4921/noita?${seed}&hey_you_reading_this_you_will_find_literally_nothing_and_just_waste_your_time" | Select-Object -ExpandProperty Content
		$a -replace ",","`n  " -replace ";","`n"
	}
	sleep 5
}