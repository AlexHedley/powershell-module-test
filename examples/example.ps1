#Uninstall-Module powershell-module-test
Remove-Module powershell-module-test

Import-Module -Name $PSScriptRoot\..\code\powershell-module-test -verbose
#Import-Module -Name D:\CODE\GitHub\AlexHedley\powershell-module-test\code\powershell-module-test.psd1 -Force

# http://jeffwouters.nl/index.php/2014/11/loading-the-amazon-aws-powershell-module/
# https://adamtheautomator.com/powershell-modules/
# https://4sysops.com/archives/how-to-export-powershell-module-functions/

#ModuleType Version    Name                                ExportedCommands                                                                                                                    
#---------- -------    ----                                ----------------                                                                                                                    
#Manifest   1.0        powershell-module-test                               
# Missing https://stackoverflow.com/a/48451540

Get-Module powershell-module-test
#Get-InstalledModule powershell-module-test

#Update-Module powershell-module-test
#Get-Module powershell-module-test

#Get-Command -Module powershell-module-test
#Get-Module powershell-module-test -ListAvailable | % { $_.ExportedCommands.Values }
#Get-Command -Module powershell-module-test -CommandType cmdlet
#Get-Command -Module powershell-module-test -CommandType Function

Get-PowerShellProcess

Add-Numbers -one 1 -two 2
