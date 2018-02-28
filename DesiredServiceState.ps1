configuration DesiredServiceState
{
    param(
        [Array]$ServiceNames
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        foreach($service in $ServiceNames)
        {
            $name="$($service)-ShouldBe-Automatic-and-Running"
            Service $name
            {
                Name        = $service
                StartupType = "Automatic"
                State       = "Running"
            } 
        }
    }
}

#Generate MOF-File
#$services = @('Eventlog','MpsSvc','LanmanServer','Schedule','wuauserv','Netlogon','WinRM','W32Time')
#DesiredServiceState -ServiceNames $services -OutputPath "C:\Work\DscRepo"

#Start DSC Configuration manual
#Start-DscConfiguration -Path "C:\Work\DscRepo" -Verbose -Wait -Force
