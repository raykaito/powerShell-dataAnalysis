. "$($PSScriptRoot)\lib\grapher.ps1"

$pathRawData = "$($PSScriptRoot)\..\data\raw"

#draw("$($PSScriptRoot)\..\data\firstGraph.png")

foreach($pn in 1..3){
    foreach($date in 10..30) {
        New-Item -Path "$($pathRawData)\div4\2210\$($pn)-$($date)-1.txt" -Value $_ -Force
    }
}

Read-Host -Prompt "Press Enter to Exit"