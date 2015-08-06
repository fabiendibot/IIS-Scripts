# This script will invoke a DSC configuration
# This is a simple proof of concept

"`n`tPerforming Prerequiremens`n"
   
# Install IIS8 at first
Install-WindowsFeature -Name Web-WebServer,Web-Scripting-Tools
Install-WindowsFeature Web-Mgmt-Compat -IncludeAllSubFeature
New-Item -ItemType Directory -Path C:\Repository

"`n`tExecuting script`n"

. .\CreateVirtualDirectory.ps1
 

