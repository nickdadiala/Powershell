# Checks before you run this script and confirm Password state is "0"
Get-CimInstance -Namespace root/WMI -ClassName Lenovo_BiosPasswordSettings
#Run the commands to set initial Supervisor Password and replace it
$setPW = Get-WmiObject -Namespace root/WMI -class Lenovo_SetBiosPassword
#
$setPW.SetBioPassword ("pap,secretpassword,secretpassword,ascii,us")

Function New-LenovoSetBIOSPassword 
{
   param(
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Namespace,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$ClassName,
        [Parameter(Mandatory=$true)][ValidateNotNull()][securestring]$password,
        [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()][securestring]$setPW
        )
}
 If($setPW)
  {
    $bytes= $Script:Encoder.GetBytes($setPW)
    if(($securityInterface.SetBioPassword(1,$setPW.length,$bytes,$password)).status -eq 0)
  {
    Write-output -Value "$password.Password is set "
  }
     
  }     