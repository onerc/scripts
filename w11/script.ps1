$programs = Get-Content programs.json | ConvertFrom-Json
$programs | Format-Table
foreach ($program in $programs) {
  Write-Host "Starting:"$program.nice_name
  Start-Process "shell:AppsFolder\$(Get-StartApps | Where-Object name -eq $program.nice_name | Select-Object -ExpandProperty AppId)" 
  Start-Sleep 10
  if ($program.process_name -eq "n/a") {
    Write-Host "NOT Killing:"$program.nice_name`n
  }
  else {
    Write-Host "Killing:"$program.nice_name`n
    Stop-Process -name $program.process_name
  } 
}
