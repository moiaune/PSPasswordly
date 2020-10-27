Function ConvertTo-Capitalized {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]
        $Value
    )

    return $Value.Substring(0, 1).ToUpper() + $Value.Substring(1)
}