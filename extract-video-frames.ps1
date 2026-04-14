$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$videoPath = 'C:\Users\Susana\Desktop\Resilient Strategy\v 7.0\Sipass Testing Session 14-04-26.mp4'
$outDir = 'C:\Users\Susana\.copilot\session-state\2c41b785-25a0-4740-8d9a-f9e570470658\files\video-frames'
$timestamps = @(0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540)

if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]$videoPath)

for ($i = 0; $i -lt 50 -and ($player.NaturalVideoWidth -le 0 -or $player.NaturalVideoHeight -le 0); $i++) {
    Start-Sleep -Milliseconds 200
}

if ($player.NaturalVideoWidth -le 0 -or $player.NaturalVideoHeight -le 0) {
    throw 'Video did not open with a readable size.'
}

$width = $player.NaturalVideoWidth
$height = $player.NaturalVideoHeight
$rect = New-Object System.Windows.Rect(0, 0, $width, $height)

foreach ($seconds in $timestamps) {
    $player.Position = [TimeSpan]::FromSeconds($seconds)
    Start-Sleep -Milliseconds 800

    $drawingVisual = New-Object System.Windows.Media.DrawingVisual
    $drawingContext = $drawingVisual.RenderOpen()
    $drawingContext.DrawVideo($player, $rect)
    $drawingContext.Close()

    $bitmap = New-Object System.Windows.Media.Imaging.RenderTargetBitmap($width, $height, 96, 96, [System.Windows.Media.PixelFormats]::Pbgra32)
    $bitmap.Render($drawingVisual)

    $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
    $encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($bitmap))

    $outFile = Join-Path $outDir ('frame-{0:D4}.png' -f $seconds)
    $stream = [System.IO.File]::Open($outFile, [System.IO.FileMode]::Create)
    try {
        $encoder.Save($stream)
    }
    finally {
        $stream.Dispose()
    }
}

$player.Close()
Get-ChildItem -Path $outDir -Filter '*.png' | Select-Object -ExpandProperty FullName
