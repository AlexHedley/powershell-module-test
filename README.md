# powershell-module-test

[![Build Status](https://alexhedley.visualstudio.com/powershell-module-test/_apis/build/status/AlexHedley.powershell-module-test?branchName=master)](https://alexhedley.visualstudio.com/powershell-module-test/_build/latest?definitionId=1&branchName=master)

[![powershellgallery](https://img.shields.io/powershellgallery/v/powershell-module-test.svg)](https://www.powershellgallery.com/packages/powershell-module-test)
 | 
[![downloads](https://img.shields.io/powershellgallery/dt/powershell-module-test.svg?label=downloads)](https://www.powershellgallery.com/packages/powershell-module-test)

A PowerShell Module Test

Create a `.psm1`

Then create a `.psd1`

```powershell
New-ModuleManifest -Path $PSScriptRoot\powershell-module-test.psd1
```
