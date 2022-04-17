Function double($Argument){
    Return $Argument * 2
}

Function draw($graphName){
    Add-Type -AssemblyName System.Drawing

    $filename = $graphName 
    $bmp = new-object System.Drawing.Bitmap 720,480 
    $font = new-object System.Drawing.Font Consolas,24 
    $brushBg = [System.Drawing.Brushes]::Yellow 
    $brushFg = [System.Drawing.Brushes]::Black 
    $graphics = [System.Drawing.Graphics]::FromImage($bmp) 
    $graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
    $graphics.DrawString('Hello World',$font,$brushFg,10,10) 
    $graphics.Dispose() 
    $bmp.Save($filename) 

    Invoke-Item "$($filename)\.."  
}