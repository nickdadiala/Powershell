# Pleas read the steps before you run this script. The buils script is to set the BIOS password for Dell
#Connect to the PasswordObject WMI class
$Password = Get-CimInstance -Namespace root\dcim\sysman\wmisecurity -ClassName PasswordObject
 
#Check the status of the admin password
$Password | Where-Object NameId -EQ "Admin" | Select-Object -ExpandProperty IsPasswordSet
 
#Check the status of the system password
$Password | Where-Object NameId -EQ "System" | Select-Object -ExpandProperty IsPasswordSet
#encodedMethod
$Password = "SamplePass"
$Encoder = New-Object System.Text.UTF8Encoding
$Bytes = $Encoder.GetBytes($Password)
Function Get-WMIData
{
 Param(
    [Paramaters(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$Namespace,
    [Paramaters(Mandatory=$true)][ValidateNotNullOrEmpty()][String]$Classname,
    [Paramaters(Mandatory=$true)][ValidateSet('CIM','WMI')]$cmdletType,
    [Paramaters(Mandatory=$false)][ValidateNotNullOrEmpty()][String[]]$select
)
 $counter =0
while($Counter -lt 6)
	{
		if($CmdletType -eq "CIM")
		{
			if($Select)
			{
				Write-LogEntry -Value "Get the $Classname WMI class from the $Namespace namespace and select properties: $Select" -Severity 1
				$Query = Get-CimInstance -Namespace $Namespace -ClassName $ClassName -ErrorAction SilentlyContinue | Select-Object $Select -ErrorAction SilentlyContinue
			}
			else
			{
				Write-LogEntry -Value "Get the $ClassName WMI class from the $Namespace namespace" -Severity 1
				$Query = Get-CimInstance -Namespace $Namespace -ClassName $ClassName -ErrorAction SilentlyContinue
			}
		}
		elseif($CmdletType -eq "WMI")
		{
			if($Select)
			{
				Write-LogEntry -Value "Get the $Classname WMI class from the $Namespace namespace and select properties: $Select" -Severity 1
				$Query = Get-WmiObject -Namespace $Namespace -Class $ClassName -ErrorAction SilentlyContinue | Select-Object $Select -ErrorAction SilentlyContinue
			}
			else
			{
				Write-LogEntry -Value "Get the $ClassName WMI class from the $Namespace namespace" -Severity 1
				$Query = Get-WmiObject -Namespace $Namespace -Class $ClassName -ErrorAction SilentlyContinue
			}
		}
		if($NULL -eq $Query)
		{
			if($Select)
			{
				Write-LogEntry -Value "An error occurred while attempting to get the $Select properties from the $Classname WMI class in the $Namespace namespace. Retry in 30 seconds" -Severity 2
			}
			else
			{
				Write-LogEntry -Value "An error occurred while connecting to the $Classname WMI class in the $Namespace namespace. Retry in 30 seconds" -Severity 2
			}
			Start-Sleep -Seconds 30
			$Counter++
		}
		else
		{
			break
		}
	}
	if($NULL -eq $Query)
	{
		if($Select)
		{
			Stop-Script -ErrorMessage "An error occurred while attempting to get the $Select properties from the $Classname WMI class in the $Namespace namespace"
		}
		else
		{
			Stop-Script -ErrorMessage "An error occurred while connecting to the $Classname WMI class in the $Namespace namespace"
		}
	}
	Write-LogEntry -Value "Successfully connected to the $ClassName WMI class" -Severity 1
	return $Query
}
 
Function New-DellBiosPassword
{
    Param(
       [Parameter(Mandatory=$true)][ValidateSet('Admin','System')][SecureString] $passwordType,
       [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][SecureString]$Password,
       [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()][String]$adminPW
    ) 
    if($adminPW)
    {
     $adminbytes = $script:Encoder.GetBytes($adminPW)
    if(($securityInterface.SetNewPassword(1,$adminPW.Length, $adminbytes,$adminPW,$passwordType,$Password)).Status -eq 0)
    {
        Write-Output -Value "$passwordtype.password is set"
    }   
      else {
        Write-Output -Name"$($passwordType)Password exist" -value "Failed"
      }
    }
} 
    # Set the admin or system password
    else {
        if (($securityInterface.SetNewPassword(0,0,0,$passwordType,"",$Password)).Status -eq 0)
        {
            Write-Output -value "$passwordtype.password is set"
            else {
                Write-Output -name"$($passwordType)Password exist" - Value"Failed"
            }
        }
    }  
# Set user prompt for max attempts to set password
  $setPassword = "$false"
 $MaxAttempts = "3"
  $attempt = "0"
  $authenticated = "$false"
   While($attempt -lt $MaxAttempts -and -not $authenticated ,$SetPassword) {
    $attempt +=1
    $setPassword= Read-host -prompt "enter password($attempt of $maxattempts)"
   If 
   ($setPassword.length -ge 12) {
    Write-host "Passlength correct and meet the requirement"
    $authenticated =$true
   }
   Else {
    Write-Host "Incorrect password enter"
   }
}
 if (-not $setPassword) {
    Write-Host " prompt $maxattempts reached its limit"
 }
   
