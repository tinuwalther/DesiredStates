#Write DSC Configuration for configure LCM
[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node localhost
    {
        Settings
        {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode       = 'Push'
        }
    }
}

#Generate MOF-File
#LCMConfig -OutputPath "D:\Work\LCMConfig"

#Set DSC LCMConfig
#Set-DscLocalConfigurationManager -Path "D:\Work\LCMConfig" -ComputerName localhost

#Get DSC LCMConfig
#Get-DscLocalConfigurationManager
