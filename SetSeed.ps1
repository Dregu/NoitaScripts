<#
    Run the game with custom seed. Only 1-4294967295 are valid.
    This will delete your current world (not stats). You have been warned.
#>
param (
	[string]$seed = $(Read-Host "Enter seed")
)
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
Remove-Item $gamepath\magic.txt
$magic = "<MagicNumbers WORLD_SEED=`"$seed`" />"
[System.IO.File]::WriteAllLines("$gamepath\magic.txt", $magic)
Remove-Item ${Env:UserProfile}\AppData\LocalLow\Nolla_Games_Noita\save00\magic_numbers.salakieli
Remove-Item ${Env:UserProfile}\AppData\LocalLow\Nolla_Games_Noita\save00\world_state.salakieli
Remove-Item ${Env:UserProfile}\AppData\LocalLow\Nolla_Games_Noita\save00\player.salakieli
Remove-Item ${Env:UserProfile}\AppData\LocalLow\Nolla_Games_Noita\save00\world -recurse
Push-Location $gamepath
Invoke-Expression "& `".\noita.exe`" -magic_numbers magic.txt -no_logo_splashes"
Pop-Location