configuration DesiredServiceState
{
    param(
        [Array]$ServiceNames,
        [String]$StartupType,
        [String]$ServiceState
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        foreach($ServiceName in $ServiceNames)
        {
            $name="$($ServiceName)-ShouldBe-Automatic-and-Running"
            Service $name
            {
                Name        = $ServiceName
                StartupType = $StartupType
                State       = $ServiceState
            } 
        }
    }
}

#Generate MOF-File
$autoservices   = @('Eventlog','MpsSvc','LanmanServer','Schedule','WinRM')
$StartupType    = 'Automatic'
$ServiceState   = 'Running'
#DesiredServiceState -ServiceNames $services -OutputPath "C:\Work\DscRepo"

$manualservices = @('wuauserv','Netlogon','W32Time')
$StartupType    = 'Manual'
$ServiceState   = 'Stopped'

#Start DSC Configuration manual
#Start-DscConfiguration -Path "C:\Work\DscRepo" -Verbose -Wait -Force
