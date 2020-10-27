<#
.SYNOPSIS
Generates a new password.
.DESCRIPTION
This function will generate passwords based on parameters. It can generate either a random string or a string based on words concatenated.
.PARAMETER Word
Will generate a string based on words concatenated.
.PARAMETER Delimiter
Set's delimiter between words. Default "-". Only applicable if -Word.
.PARAMETER NumberOfWords
Number of words to include in the output. Default 3. Only applicable if -Word.
.PARAMETER WordlistPath
Path to a textfile with custom words. Words must be line separated.
.PARAMETER String
Will generate a random string based on parameters.
.PARAMETER Upper
Will include UPPERCASE letters. Only applicable if -String.
.PARAMETER Lower
Will include lowercase letters. Only applicable if -String.
.PARAMETER Digits
Will include digits. Only applicable if -String.
.PARAMETER Symbols
Will include symbols (@!-*#%). Only applicable if -String.
.PARAMETER Length
Number of characters to include in the random string. Only applicable if -String.
.PARAMETER Prefix
Will include a random number between 1111-9999 at the begining.
.PARAMETER Suffix
Will include a random number between 1111-9999 at the end.
.PARAMETER Count
Number of passwords to generate.
.EXAMPLE
Default action is 3 words concatenated together with "-".

PS /> New-Passwordly

Password
--------
Governor-Opinion-Gasp
.EXAMPLE
PS /> New-Passwordly -NumberOfWords 3 -Count 3 -Prefix -Suffix -Delimiter "//"

Password
--------
9192//Overcharge//Mourning//Increase//5169
6989//Increase//Gasp//Mourning//8013
4236//Safety//Increase//Comprehensive//5015
.EXAMPLE
PS /> "Powershell", "Microsoft", "PSGallery", "Awesome" | Out-File -Path "CustomWordlist.txt"
PS /> Invoke-Passwordly -WordlistPath ./CustomWordlist.txt

Password
--------
Microsoft-Powershell-Awesome

#>
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
                    Password = $Words -join ($Delimiter)
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