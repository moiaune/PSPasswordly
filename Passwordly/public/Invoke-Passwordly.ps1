Function Invoke-Passwordly {
    [CmdletBinding(DefaultParameterSetName = "Word")]
    param (
        [Parameter(ParameterSetName="Word")]
        [switch]
        $Word,

        [Parameter(ParameterSetName="Word")]
        [String]
        $Delimiter = "-",

        [Parameter(ParameterSetName="Word")]
        [int]
        $NumberOfWords = 3,

        [Parameter(ParameterSetName="Word")]
        [String]
        $WordlistPath = "",

        [Parameter(ParameterSetName="String")]
        [switch]
        $String,

        [Parameter(ParameterSetName="String")]
        [Switch]
        $Upper,

        [Parameter(ParameterSetName="String")]
        [Switch]
        $Lower,

        [Parameter(ParameterSetName="String")]
        [Switch]
        $Digits,

        [Parameter(ParameterSetName="String")]
        [Switch]
        $Symbols,

        [Parameter(ParameterSetName="String")]
        [int]
        $Length = 16,

        [Parameter()]
        [Switch]
        $Prefix,

        [Parameter()]
        [Switch]
        $Suffix,

        [Parameter()]
        [int]
        $Count = 1
    )

    begin {
        if ($PSCmdlet.ParameterSetName -eq "Word") {
            $Wordlist = Initialize-Wordlist -Path $WordlistPath
        }
        
        if ($PSCmdlet.ParameterSetName -eq "String") {
            $KeyspaceOptions = @{
                Upper = $Upper
                Lower = $Lower
                Digits = $Digits
                Symbols = $Symbols
            }

            $Keyspace = Initialize-Keyspace @KeyspaceOptions
        }
    }

    process {

        #region Generate Word passwords
        if ($PSCmdlet.ParameterSetName -eq "Word") {
            foreach ($x in 1..$Count) {
                $Words = New-Object -TypeName "System.Collections.ArrayList"

                foreach($y in 1..$NumberOfWords) {

                    do {
                        $RandomWord = ConvertTo-Capitalized -Value $Wordlist[(Get-Random -Max $Wordlist.Length)]
                    } while($Words.Contains($RandomWord))
                    
                    $Words.Add($RandomWord) | Out-Null

                }

                if ($Prefix) {
                    $Words.Insert(0, (Get-Random -Min 1111 -Max 9999).ToString()) | Out-Null
                }

                if ($Suffix) {
                    $Words.Add((Get-Random -Min 1111 -Max 9999).ToString()) | Out-Null
                }

                $Obj = [PSCustomObject]@{
                    Password = $Words -join "-"
                }

                $Obj
            }
        }
        #endregion

        #region Generate String passwords
        if ($PSCmdlet.ParameterSetName -eq "String") {
            foreach ($x in 1..$Count) {

                do {
                    $Chars = New-Object -TypeName "System.Collections.ArrayList"
                    
                    foreach ($y in 1..$Length) {
                        $Chars.Add($Keyspace[(Get-Random -Max $Keyspace.Length)]) | Out-Null
                    }

                } while (-not (Test-ContainsRequiredChars @KeyspaceOptions -Value ($Chars -join "")))

                if ($Prefix) {
                    $Chars.Insert(0, (Get-Random -Min 1111 -Max 9999).ToString()) | Out-Null
                }

                if ($Suffix) {
                    $Chars.Add((Get-Random -Min 1111 -Max 9999).ToString()) | Out-Null
                }

                $Obj = [PSCustomObject]@{
                    Password = $Chars -join ""
                }
                
                $Obj
            }
        }
        #endregion
    }

    end {
        
    }
}