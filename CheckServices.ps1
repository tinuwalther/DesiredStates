# Get all Services with StartMode Automatic
Get-WmiObject Win32_Service | Where-Object {$_.StartMode -eq 'Auto'} | Select Name,DisplayName,State,StartMode | ft -AutoSize

# Export Service Configuration to a JSON
$services = @('Eventlog','MpsSvc','LanmanServer','Schedule','wuauserv','Netlogon','WinRM','W32Time')
$psoServices = @()
foreach($item in $services){
    Get-WmiObject Win32_Service | Where-Object {$_.Name -eq $item} | Select-Object Name,DisplayName,State,StartMode,Started | % {
        $obj = [PSCustomObject]@{
            Name        = $_.Name
            DisplayName = $_.DisplayName
            State       = $_.State
            StartMode   = $_.StartMode
            Started     = $_.Started
        }
        $psoServices += $obj
    }
}
$psoServices | ft -AutoSize
$psoServices | ConvertTo-Json -Compress | Out-File 'C:\Work\Services.json'
