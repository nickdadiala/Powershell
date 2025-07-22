# This script is practice to fix Error of NUllorEmpty whne running PS.
Param(
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$FilePath
    )
    #To check if File path is null or empty
    if([string]::IsNullOrEmpty($FilePath)) {
        Write-Host "Error:Filepath paramter is null or empty"
        Exit 1
    }
    else {
        If(-not(Test-Path -Path $FilePath -PathType Leaf)){
            Write-Host "Error: file doesnt not exist"
            exit 1
        }
    }