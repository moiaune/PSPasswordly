# Passwordly

A simple password generator written in Powershell.

## Introduction

Passwordly is a simple password generator written in Powershell that can generate either random strings or a list of words concatenated together.

## Installation

The module can be installed from [PSGallery](https://www.powershellgallery.com/packages/Passwordly).

```
Install-Module -Name PSPasswordly 
```

## Examples

```
PS / > Import-Module PSPasswordly
PS /> Invoke-Passwordly

Password
--------
Governor-Opinion-Gasp

PS /> Invoke-Passwordly -NumberOfWords 5 -Suffix

Password
--------
Governor-Empirical-Infinite-Mourning-Characteristic-2907

PS /> Invoke-Passwordly -NumberOfWords 3 -Count 3 -Prefix -Suffix -Delimiter "//"

Password
--------
9192//Overcharge//Mourning//Increase//5169
6989//Increase//Gasp//Mourning//8013
4236//Safety//Increase//Comprehensive//5015

PS /> Invoke-Passwordly -String -Upper -Lower -Digits -Symbols -Prefix -Suffix -Length 16 -Count 3

Password
--------
1602IOnE8x%9%LYXWBS96863
9779a0#91wd8jCPtbl@W6752
4869V3%Pu3aoO3Ri4Vmg2094

```
