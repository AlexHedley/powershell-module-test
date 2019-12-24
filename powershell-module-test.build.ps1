# https://github.com/stefanstranger/psjwt/blob/master/PSJwt.build.ps1

<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>

param ($Configuration = 'Development')

#region use the most strict mode
Set-StrictMode -Version Latest
#endregion

#region Task to Update the PowerShell Module Help Files.
# Pre-requisites: PowerShell Module PlatyPS.
task UpdateHelp {
    Import-Module .\code\powershell-module-test.psd1 -Force
    Update-MarkdownHelp .\docs 
    New-ExternalHelp -Path .\docs -OutputPath .\en-US -Force
}
#endregion

#region Task to Copy PowerShell Module files to output folder for release as Module
task CopyModuleFiles {

    # Copy Module Files to Output Folder
    if (-not (Test-Path .\output\powershell-module-test)) {
        $null = New-Item -Path .\output\powershell-module-test -ItemType Directory
    }

    Copy-Item -Path '.\code\en-US\' -Filter *.* -Recurse -Destination .\output\powershell-module-test -Force
    #Copy-Item -Path '.\lib\' -Filter *.* -Recurse -Destination .\output\powershell-module-test -Force
    Copy-Item -Path '.\code\public\' -Filter *.* -Recurse -Destination .\output\powershell-module-test -Force
    #Copy-Item -Path '.\tests\' -Filter *.* -Recurse -Destination .\output\powershell-module-test -Force
    
    #Copy Module Manifest files
    Copy-Item -Path @(
        '.\code\README.md'
        '.\code\powershell-module-test.psd1'
        '.\code\powershell-module-test.psm1'
    ) -Destination .\output\powershell-module-test -Force        
}
#endregion

#region Task to run all Pester tests in folder .\tests
task Test {
    $Result = Invoke-Pester .\tests -PassThru
    if ($Result.FailedCount -gt 0) {
        throw 'Pester tests failed'
    }

}
#endregion

#region Task to update the Module Manifest file with info from the Changelog in Readme.
task UpdateManifest {
    # Import PlatyPS. Needed for parsing README for Change Log versions
    Import-Module -Name PlatyPS

    # Find Latest Version in README file from Change log.
    $README = Get-Content -Path .\README.md
    $MarkdownObject = [Markdown.MAML.Parser.MarkdownParser]::new()
    [regex]$regex = '\d\.\d\.\d'
    $Versions = $regex.Matches($MarkdownObject.ParseString($README).Children.Spans.Text) | foreach-object {$_.value}
    ($Versions | Measure-Object -Maximum).Maximum

    $manifestPath = '.\code\powershell-module-test.psd1'
 
    # Start by importing the manifest to determine the version, then add 1 to the Build
    $manifest = Test-ModuleManifest -Path $manifestPath
    [System.Version]$version = $manifest.Version
    [String]$newVersion = New-Object -TypeName System.Version -ArgumentList ($version.Major, $version.Minor, ($version.Build + 1))
    Write-Output -InputObject ('New Module version: {0}' -f $newVersion)

    # Update Manifest file with Release Notes
    $README = Get-Content -Path .\README.md
    $MarkdownObject = [Markdown.MAML.Parser.MarkdownParser]::new()
    $ReleaseNotes = ((($MarkdownObject.ParseString($README).Children.Spans.Text) -match '\d\.\d\.\d') -split ' - ')[1]
    
    #Update Module with new version
    Update-ModuleManifest -ModuleVersion $newVersion -Path .\powershell-module-test.psd1 -ReleaseNotes $ReleaseNotes
}
#endregion

#region Task to Publish Module to PowerShell Gallery
task PublishModule -If ($Configuration -eq 'Production') {
    Try {
        # Build a splat containing the required details and make sure to Stop for errors which will trigger the catch
        $params = @{
            Path        = ('{0}\Output\powershell-module-test' -f $PSScriptRoot )
            NuGetApiKey = $env:NUGETAPIKEY
            ErrorAction = 'Stop'
        }
        Publish-Module @params
        Write-Output -InputObject ('powershell-module-test PowerShell Module version published to the PowerShell Gallery')
    }
    Catch {
        throw $_
    }
}
#endregion

#region Task clean up Output folder
task Clean {
    # Clean output folder
    if ((Test-Path .\output)) {
        Remove-Item -Path .\Output -Recurse -Force
    }
}
#endregion

#region Default Task. Runs Clean, Test, CopyModuleFiles Tasks
task . Clean, Test, CopyModuleFiles, PublishModule
#endregion