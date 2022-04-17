. "$($PSScriptRoot)\lib\grapher.ps1"

$pathRawData = "$($PSScriptRoot)\..\data\raw"

draw("$($PSScriptRoot)\..\data\firstGraph.png")

1..20 | foreach {
    New-Item -Path "$($pathRawData)\$_.txt" -Value $_ -Force
}

Read-Host -Prompt "Press Enter to Exit"