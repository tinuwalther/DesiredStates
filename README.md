# DesiredStates

## DesiredServiceState.ps1  
The DesiredServiceState-Configuration configure:  
- all specified services to automatic and running inclusive of their depended services  
- all specified services to disabled and stopped.   

Its backwards compatible to PowerShell v4.0. For PowerShell V5 or greather, you can use the Resource ServiceSet.

https://docs.microsoft.com/en-us/powershell/dsc/servicesetresource
