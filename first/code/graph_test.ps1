Function draw($graphName){
    #DefineParameters
    $width = 720
    $height= 480
    $plot_x_0 = 60
    $plot_x_1 = 670
    $plot_y_0 = 420
    $plot_y_1 = 50

    #Prepare Graph
    Add-Type -AssemblyName System.Drawing
    $bmp = new-object System.Drawing.Bitmap $width,$height 
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)

    #Fill Background
    $backGround = [System.Drawing.Brushes]::gray 
    $graphics.FillRectangle($backGround,0,0,$bmp.Width,$bmp.Height) 

    #Draw Axis
    $Pen = [Drawing.Pens]::Black
    $graphics.DrawLine($Pen,$plot_x_0,$plot_y_0,$plot_x_1,$plot_y_0) 
    $graphics.DrawLine($Pen,$plot_x_0,$plot_y_0,$plot_x_0,$plot_y_1)
    
    #Draw plots
    $BrushBlue = [System.Drawing.Brushes]::Blue 
    $graphics.FillEllipse($BrushBlue,101,210,3,3)

    #Draw Strings
    $fontColor = [System.Drawing.Brushes]::Black  
    $font = new-object System.Drawing.Font Arial, 12
    $graphics.DrawString('My Graph',$font,$fontColor,10,10)

    #Draw xyguide
    $StringFormat = [System.Drawing.StringFormat]::New()
    $StringFormat.Alignment = "Center"
    $StringFormat.LineAlignment = "Center"
    $graphics.DrawString("Here",$font,$fontColor,$plot_x_0,$plot_y_0+12,$StringFormat)

    $graphics.Dispose() 
    $bmp.Save($graphName) 

    Invoke-Item "$($graphName)"
}
$pathRawData = "$($PSScriptRoot)\..\data\raw"

draw "C:\Users\Kazuk\Documents\GitHub\powerShell-dataAnalysis\first\data\firstGraph.png"

#Read-Host -Prompt "Press Enter to Exit"