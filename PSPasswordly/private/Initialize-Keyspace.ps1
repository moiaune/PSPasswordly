<#
.SYNOPSIS
Creates a random string with Uppercase, Lowercase, Digits and Symbols based on parameters passed.
#>
Function Initialize-Keyspace {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]
        $Upper,
        
        [Parameter()]
        [switch]
        $Lower,
        
        [Parameter()]
        [switch]
        $Digits,
        
        [Parameter()]
        [switch]
        $Symbols
    )

    $Keyspace = ""

    if ($Upper) {
        $Keyspace += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    }

    if ($Lower) {
        $Keyspace += "abcdefghijklmnopqrstuvwxyz"
    }

    if ($Digits) {
        $Keyspace += "0123456789"
    }

    if ($Symbols) {
        $Keyspace += "@!-*#%"
    }

    return ($Keyspace -split "" | Sort-Object { Get-Random }) -join ""
}