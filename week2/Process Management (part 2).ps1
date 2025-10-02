#Script that lists every process thats path does NOT include 'system32'

Get-Process | Where-Object {($_.Path -notlike "*system32*")} | Select Name, Path, ID