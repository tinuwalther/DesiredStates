configuration DesiredServiceState{
    param(
        [Array]$Services
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost{
        foreach($item in $Services){
            $name="$($item.ServiceName)-ShouldBe-$($item.ServiceType)-and-$($item.ServiceState)"
            Write-Verbose $name -Verbose
            Service $name{
                Name        = $item.ServiceName
                StartupType = $item.ServiceType
                State       = $item.ServiceState
            }
        }
    }
}

#Generate PSCustomObject of ServiceConfiguration
$ServiceConfiguration  = @()

#Generate configuration of the automatic services and their required services
$AutoRunningServices   = @('Eventlog','MpsSvc','LanmanServer','Schedule','WinRM')
$RequiredAutoServices  = (Get-Service $AutoRunningServices).RequiredServices.Name
foreach($item in $RequiredAutoServices){
    if($AutoRunningServices -notcontains $item){
        $AutoRunningServices += $item
    }
}
foreach($item in $AutoRunningServices){ 
    [PSCustomObject]$ServiceObject = @{
        ServiceName  = $item
        ServiceType  = 'Automatic'
        ServiceState = 'Running'
    }
    $ServiceConfiguration += $ServiceObject
}

#Generate configuration of the disabled services
$DisabledStoppedServices = @('NetTcpPortSharing','SharedAccess')
foreach($item in $DisabledStoppedServices){ 
    [PSCustomObject]$ServiceObject = @{
        ServiceName  = $item
        ServiceType  = 'Disabled'
        ServiceState = 'Stopped'
    }
    $ServiceConfiguration += $ServiceObject
}

#Generate MOF-File
DesiredServiceState -Services $ServiceConfiguration -OutputPath "C:\Work\DscRepo"

#Start DSC Configuration manual
Start-DscConfiguration -Path "C:\Work\DscRepo" -Verbose -Wait -Force
