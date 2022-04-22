#Define source and destination directory (RESULTS\OK)
$copyFromList = @(
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw\div1",
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw\div2",
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw\div3"
)
$copyToList = @(
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw_copy\div1",
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw_copy\div2",
    "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\raw_copy\div3"
)

$dateTimeStart = 2
$dateTimeLength = 4

Function copy_newer_items ($pathResultOkSrc, $pathResultOkDest){

    #Get month list in source and Dest
    $monthListSrc = Get-ChildItem -Path $pathResultOkSrc -Directory
    $monthListDest = Get-ChildItem -Path $pathResultOkDest -Directory

    if($monthListDest.Length -gt 0){
        #Get latest folder in Dest
        $latestMonthName = $monthListDest.Name | measure -Maximum
        $latestMonthName = $latestMonthName.Maximum
        $latestMonthDir = "$($pathResultOkDest)\$latestMonthName\"

        #Get file list in srouce(latest month)
        $fileListSrc = Get-ChildItem -Path "$($pathResultOkSrc)\$latestMonthName"

        #In latest month dir, get latest file
        $fileListDest = Get-ChildItem -Path "$($pathResultOkDest)\$latestMonthName"
        $fileListDestInt = @()
        foreach ($file in $fileListDest) {
            $fileListDestInt += $file.Name.Substring($dateTimeStart,$dateTimeLength) -replace "[^0-9]" , ''
        }
        $latestFileName = $fileListDestInt | measure -Maximum
        $latestFileName = $latestFileName.Maximum

        #Copy newer files
        foreach($fileSrc in $fileListSrc){
            $currentFileName = $fileSrc.Name.Substring($dateTimeStart,$dateTimeLength) -replace "[^0-9]" , ''
            if($latestFileName -gt $currentFileName){
                continue
            }
            Copy-Item -Path $fileSrc.FullName -Destination $latestMonthDir
            write("Copying...  $($latestMonthName)\$($fileSrc) @ '$($currentFileName)'")
        }

        #Copy every file in newer month dir
        foreach($monthDirSrc in $monthListSrc){
            if($latestMonthName -ge $monthDirSrc.Name){
                continue
            }
            $newMonthDir = "$($pathResultOkDest)\$($monthDirSrc.Name)\"
            New-Item $newMonthDir -ItemType Directory
            $newMonthDir = $newMonthDir
            Copy-Item -Path "$($monthDirSrc.FullName)\*" -Destination $newMonthDir -Recurse
        }
    }else{
        #Copy every folder
        foreach($monthDirSrc in $monthListSrc){
            $newMonthDir = "$($pathResultOkDest)\$($monthDirSrc.Name)\"
            New-Item $newMonthDir -ItemType Directory
            Copy-Item -Path "$($monthDirSrc.FullName)\*" -Destination $newMonthDir -Recurse
        }
    }

}

Foreach($index in 0..($copyFromList.Length-1)){
    $PathSrc = Convert-Path $copyFromList[$index]
    $PathDest= Convert-Path $copyToList[$index]
    copy_newer_items $PathSrc $PathDest
}
Read-Host -Prompt "Press Enter to Exit"
