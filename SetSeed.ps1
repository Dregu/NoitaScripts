param (
	[string]$seed = $(Read-Host "Enter seed"),
	[string]$gamepath = (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 881100").GetValue("InstallLocation")
)
if($gamepath -eq $null) {
	$gamepath = "."
}
$ErrorActionPreference='silentlycontinue'
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