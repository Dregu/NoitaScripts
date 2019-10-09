<#
    This one checks your current seed from the log for LCAP recipes using Zatherszszzs site.
    It will update on new game too.
#>
$ErrorActionPreference='silentlycontinue'
$gamepath = "."
$steampath = (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 881100").GetValue("InstallLocation")
$gogpath = (Get-Item "HKLM:\SOFTWARE\WOW6432Node\GOG.com\Games\1310457090").GetValue("path")
if(Test-Path $gamepath\noita.exe) {
	Write-Host "Found game in $gamepath"
} elseif($steampath -ne $null) {
	Write-Host "Found game on Steam"
	$gamepath = $steampath
} elseif($gogpath -ne $null) {
	Write-Host "Found game on GOG"
	$gamepath = $gogpath
}
if((Test-Path $gamepath\noita.exe) -eq $false) {
	Write-Host "I can't find your game! Put me where noita.exe is or edit the gamepath to point to the installation directory."
	Pause
	Exit 1
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