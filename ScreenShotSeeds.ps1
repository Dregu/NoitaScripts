[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
function screenshot([Drawing.Rectangle]$bounds, $path) {
	$bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
	$graphics = [Drawing.Graphics]::FromImage($bmp)
	$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
	$bmp.Save($path)
	$graphics.Dispose()
	$bmp.Dispose()
}
$bounds = [Drawing.Rectangle]::FromLTRB(0, 0, 1920, 1080)
For ($i=1; $i -le 1000; $i++) {
	.\SetSeed.ps1 -seed $i
	sleep 15
	screenshot $bounds ".\$i.png"
	Stop-Process -processname noita
}