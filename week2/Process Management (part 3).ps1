#Lists every stopped service, orders it alphabetically, and saves it to a csv

Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object DisplayName | `
Export-Csv -Path "$PSScriptRoot\outfolder\Part3Out.csv"