Function Test-ContainsRequiredChars {
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
        $Symbols,

        [Parameter()]
        [String]
        $Value
    )
    
    if ($Upper -and -not ($Value -match "[A-Z]")) {
        return $false
    }

    if ($Lower -and -not ($Value -match "[a-z]")) {
        return $false
    }

    if ($Digits -and -not ($Value -match "\d")) {
        return $false
    }

    if ($Symbols -and -not ($Value -match "[@!\-*#%]")) {
        return $false
    }

    return $true
}