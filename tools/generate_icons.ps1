$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# 1. Scholar avatar (square 480x480, center-cropped from 480x360)
ffmpeg -y -hide_banner -loglevel error -i "hqdefault.jpg" -vf "crop=360:360:60:0,scale=480:480" "assets\images\scholar_malama.png"

# 2. Legacy launcher icons
$legacy = @{
  "android\app\src\main\res\mipmap-mdpi\ic_launcher.png"   = 48
  "android\app\src\main\res\mipmap-hdpi\ic_launcher.png"   = 72
  "android\app\src\main\res\mipmap-xhdpi\ic_launcher.png"  = 96
  "android\app\src\main\res\mipmap-xxhdpi\ic_launcher.png" = 144
  "android\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png"= 192
}
foreach ($k in $legacy.Keys) {
  ffmpeg -y -hide_banner -loglevel error -i "assets\images\scholar_malama.png" -vf "scale=$($legacy[$k]):$($legacy[$k])" $k
}

# 3. Adaptive icon foregrounds (108dp per density)
$fg = @{
  "android\app\src\main\res\drawable-mdpi\ic_launcher_foreground.png"   = 108
  "android\app\src\main\res\drawable-hdpi\ic_launcher_foreground.png"   = 162
  "android\app\src\main\res\drawable-xhdpi\ic_launcher_foreground.png"  = 216
  "android\app\src\main\res\drawable-xxhdpi\ic_launcher_foreground.png" = 324
  "android\app\src\main\res\drawable-xxxhdpi\ic_launcher_foreground.png"= 432
}
foreach ($k in $fg.Keys) {
  ffmpeg -y -hide_banner -loglevel error -i "assets\images\scholar_malama.png" -vf "scale=$($fg[$k]):$($fg[$k])" $k
}

Write-Output "Icons generated."