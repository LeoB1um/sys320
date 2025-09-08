#Write a PS script that lkists every process for which ProcessName starts with 'C'

Get-Process | Where-Object Name -ilike 'C*'
