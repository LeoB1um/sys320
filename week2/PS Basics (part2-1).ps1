cd $PSScriptRoot #C:\Users\champuser\Desktop

$files=(Get-ChildItem)
for ($j=0; $j -le $files.Length ; $j++){

    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].
    }
}