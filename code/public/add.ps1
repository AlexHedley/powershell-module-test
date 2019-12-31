Function Add-Numbers($one, $two) {
    <#
    .PARAMETER one
        The first number

    .PARAMETER two
        The second number


    .EXAMPLE
        Add-Numbersy -one 1 -two 2
  #>
    $one + $two
}

Function Subtrack-Numbers($one, $two) {
    <#
    .PARAMETER one
        The first number

    .PARAMETER two
        The second number


    .EXAMPLE
        Subtrack-Numbersy -one 1 -two 2
  #>
    $one - $two
}

Function Get-PowerShellProcess {
    Get-Process PowerShell
}