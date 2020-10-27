Function Initialize-Wordlist {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $Path = ""
    )
    
    $DefaultWordlist = $("increase", "comprehensive", "crown", "gasp", "mourning", "opinion", "excuse", "thaw", "characteristic", "fix", "infinite", "attachment", "grief", "empirical", "overcharge", "philosophy", "referee", "safety", "governor", "sink")

    if (Test-Path -Path $Path) {
        try {
            $Wordlist = Get-Content -Path $Path
        } catch {
            $Wordlist = $DefaultWordlist
        }
    } else {
        $Wordlist = $DefaultWordlist
    }

    return $Wordlist
}