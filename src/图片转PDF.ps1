param(
    [string[]]$inputFiles,
    [switch]$menu
)


[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


# ==========================
# MENU MODE
# ==========================

if($menu){

    Clear-Host

    Write-Host "=========================="
    Write-Host "       Image To PDF Tool"
    Write-Host "=========================="
    Write-Host ""
    Write-Host "1. Select images / ZIP"
    Write-Host ""
    Write-Host "2. Select folder"
    Write-Host ""
    Write-Host "3. Exit"
    Write-Host ""


    $choice = Read-Host "Choose"



    if($choice -eq "1"){


        Add-Type -AssemblyName System.Windows.Forms


        $dialog = New-Object System.Windows.Forms.OpenFileDialog


        $dialog.Multiselect = $true


        $dialog.Filter = "Images and ZIP|*.jpg;*.jpeg;*.png;*.bmp;*.webp;*.zip"



        if($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){

            $inputFiles = $dialog.FileNames

        }
        else{

            exit

        }


    }



    elseif($choice -eq "2"){


        Add-Type -AssemblyName System.Windows.Forms


        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog


        $dialog.Description = "Select image folder"



        if($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){

            $inputFiles = @($dialog.SelectedPath)

        }
        else{

            exit

        }


    }



    else{

        exit

    }


}




Write-Host "======================"
Write-Host "PDF TOOL START"
Write-Host "======================"



$desktop = [Environment]::GetFolderPath("Desktop")


$time = Get-Date -Format "yyyyMMdd_HHmmss"



$work = Join-Path $env:TEMP ("PDF_TEMP_"+$time)

$out = Join-Path $env:TEMP ("PDF_OUTPUT_"+$time)



New-Item $work -ItemType Directory | Out-Null

New-Item $out -ItemType Directory | Out-Null





# ==========================
# Scan Images
# ==========================


$imageFiles=@()



foreach($item in $inputFiles){


    if(!(Test-Path $item)){
        continue
    }


    $obj=Get-Item $item




    if($obj.Extension -ieq ".zip"){


        Write-Host "Extracting ZIP:" $obj.Name


        $extract=Join-Path $work "extract"


        New-Item $extract -ItemType Directory | Out-Null


        Expand-Archive `
        -Path $obj.FullName `
        -DestinationPath $extract `
        -Force



        $imageFiles += Get-ChildItem `
        $extract `
        -Recurse `
        -File |
        Where-Object {
            $_.Extension -match "\.(jpg|jpeg|png|bmp|webp)$"
        }


    }



    elseif($obj.PSIsContainer){


        Write-Host "Scanning Folder:" $obj.Name



        $imageFiles += Get-ChildItem `
        $obj.FullName `
        -Recurse `
        -File |
        Where-Object {
            $_.Extension -match "\.(jpg|jpeg|png|bmp|webp)$"
        }


    }



    elseif($obj.Extension -match "\.(jpg|jpeg|png|bmp|webp)$"){


        $imageFiles += $obj


    }


}



Write-Host ""

Write-Host ("Images found: " + $imageFiles.Count)



if($imageFiles.Count -eq 0){

    Write-Host "No images found"

    exit

}





# ==========================
# Group
# ==========================


$groups=@{}



foreach($file in $imageFiles){


    $name=$file.BaseName


    $name=$name `
    -replace "\s*\(\d+\)$","" `
    -replace "\s*（\d+）$",""



    $name=$name.Trim()



    if(!$groups.ContainsKey($name)){

        $groups[$name]=@()

    }


    $groups[$name]+=$file.FullName


}



Write-Host ("Groups: " + $groups.Count)





# ==========================
# Create PDF
# ==========================


foreach($name in $groups.Keys){


    Write-Host "Creating:" $name


    $pdf=Join-Path $out ($name+".pdf")


    $imgs=$groups[$name] | Sort-Object



    magick `
    $imgs `
    -auto-orient `
    -density 300 `
    -quality 95 `
    $pdf


}






# ==========================
# ZIP
# ==========================


Write-Host "Creating ZIP..."



$zip=Join-Path $desktop ("PDF_Output_"+$time+".zip")



Compress-Archive `
-Path "$out\*.pdf" `
-DestinationPath $zip `
-Force




Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item $out -Recurse -Force -ErrorAction SilentlyContinue



Write-Host ""

Write-Host "======================"

Write-Host "DONE"

Write-Host $zip

Write-Host "======================"