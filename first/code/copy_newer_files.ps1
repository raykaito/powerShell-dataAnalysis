#Define source and destination directory (RESULTS\OK)
$pathResultOkSrc = Convert-Path "$($PSScriptRoot)\..\data\raw"
$pathResultOkDest = Convert-Path "$($PSScriptRoot)\..\data\raw_copy"

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
        $fileListDestInt += $file.Name -replace "[^0-9]" , ''
    }
    $latestFileName = $fileListDestInt | measure -Maximum
    $latestFileName = $latestFileName.Maximum

    #Copy newer files
    foreach($fileSrc in $fileListSrc){
        $currentFileName = $fileSrc.Name -replace "[^0-9]" , ''
        if($latestFileName -gt $currentFileName){
            continue
        }
        Copy-Item -Path $fileSrc.FullName -Destination $latestMonthDir
        write("Copying...  $latestMonthName\$fileSrc")
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

Read-Host -Prompt "Press Enter to Exit"