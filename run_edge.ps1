Set-StrictMode -Version Latest
$ErrorActionPreference = "SilentlyContinue"

Write-Host "Stopping old Flutter/Web processes..."
taskkill /F /IM dart.exe | Out-Null
taskkill /F /IM msedge.exe | Out-Null
taskkill /F /IM chrome.exe | Out-Null

Write-Host "Unlocking project attributes..."
attrib -R "." /S /D | Out-Null

Write-Host "Removing old build artifacts..."
if (Test-Path "build") {
  attrib -R "build" /S /D | Out-Null
  Remove-Item -Recurse -Force "build"
}
if (Test-Path ".dart_tool") {
  attrib -R ".dart_tool" /S /D | Out-Null
  Remove-Item -Recurse -Force ".dart_tool"
}

Write-Host "Fetching dependencies..."
flutter pub get

Write-Host "Running on Edge..."
flutter run -d edge
