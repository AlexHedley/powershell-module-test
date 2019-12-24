Install-Module -Name platyPS -Scope CurrentUser
Import-Module platyPS

#Import-Module MyAwesomeModule
#Import-Module powershell-module-test
Import-Module -Name $PSScriptRoot\..\code\powershell-module-test -verbose
#New-MarkdownHelp -Module MyAwesomeModule -OutputFolder .\docs
New-MarkdownHelp -Module powershell-module-test -OutputFolder $PSScriptRoot

#New-ExternalHelp .\docs -OutputPath en-US\
New-ExternalHelp $PSScriptRoot -OutputPath en-US\

#Import-Module MyAwesomeModule -Force
Import-Module powershell-module-test -Force
#Update-MarkdownHelp .\docs
Update-MarkdownHelp $PSScriptRoot