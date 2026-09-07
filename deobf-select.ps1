Add-Type -AssemblyName System.Windows.Forms

$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.Title = 'Select obfuscated Lua file'
$dialog.Filter = 'Lua/Text files (*.lua;*.txt)|*.lua;*.txt|All files (*.*)|*.*'
$dialog.Multiselect = $false

if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    exit 0
}

$inputFile = $dialog.FileName
$repo = $PSScriptRoot
Set-Location $repo

Write-Host ''
Write-Host 'Selected:'
Write-Host $inputFile
Write-Host ''

& node (Join-Path $repo 'tools\deobfuscate-beta-control-flow.js') $inputFile
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    Write-Host ''
    Write-Host '========================='
    Write-Host 'DEOBF FAILED'
    Write-Host '========================='
    Read-Host 'Press Enter to close'
    exit $exitCode
}

Write-Host ''
Write-Host '========================='
Write-Host 'DEOBF DONE'
Write-Host '========================='
Write-Host ''
$outputDir = Join-Path $repo 'output'
Write-Host "Output folder: $outputDir"
Start-Process explorer.exe -ArgumentList $outputDir
Read-Host 'Press Enter to close'
exit 0
