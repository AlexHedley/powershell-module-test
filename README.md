# powershell-module-test

[![Build Status](https://alexhedley.visualstudio.com/powershell-module-test/_apis/build/status/AlexHedley.powershell-module-test?branchName=master)](https://alexhedley.visualstudio.com/powershell-module-test/_build/latest?definitionId=1&branchName=master)

A PowerShell Module Test

Create a `.psm1`

Then create a `.psd1`

```powershell
New-ModuleManifest -Path $PSScriptRoot\powershell-module-test.psd1
```
