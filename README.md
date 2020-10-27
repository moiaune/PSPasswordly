# Passwordly

A simple password generator written in Powershell.

## Introduction

Passwordly is a simple password generator written in Powershell that can generate either random strings or a list of words concatenated together.

## Examples

```
PS / > Import-Module Passwordly
PS /> New-Passwordly

Password
--------
Governor-Opinion-Gasp

PS /> New-Passwordly -NumberOfWords 5 -Suffix

Password
--------
Governor-Empirical-Infinite-Mourning-Characteristic-2907

PS /> New-Passwordly -NumberOfWords 3 -Count 3 -Prefix -Suffix -Delimiter "//"

Password
--------
9835-Safety-Attachment-Mourning-3264
1135-Gasp-Thaw-Comprehensive-5268
8397-Infinite-Excuse-Opinion-6151

PS /> New-Passwordly -String -Upper -Lower -Digits -Symbols -Prefix -Suffix -Length 16 -Count 3

Password
--------
1602IOnE8x%9%LYXWBS96863
9779a0#91wd8jCPtbl@W6752
4869V3%Pu3aoO3Ri4Vmg2094

```