# Checks before you run this script and confirm Password state is "0"
Get-CimInstance -Namespace root/WMI -ClassName Lenovo_BiosPasswordSettings
#Run the commands to set initial Supervisor Password and replace it
$setPW = Get-WmiObject -Namespace root/WMI -class Lenovo_SetBiosPassword
#
$setPW.SetBiosPassword("pap,secretpassword,secretpassword,ascii,us")
# Chekc the status TPM physical presence
$tpm = Get-Tpm
 Write-Host "TPM presence: $($tpm.Tpmpresence)"
 Write-Host "Tpm Enabled: $($tpm.TpmEnabled)"
 Write-host "Tpm Disabled: $($tpm.TpmDisabled)"
  If($tpm.Tpmpresence -and -not $tpm.TpmDisbaled) 
  {
    Write-Host "tpm is present and need to be cleared"
  }else{
    Write-Host "Tpm is not presnt and can not be cleared"
  }
Function New-LenovoSetBIOSPassword 
{
   param(
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Namespace,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$ClassName,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][securestring]$password,
        [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()][string]$setPW                                                        
        )
}
 If($setPW)
  {
    $bytes= $Script:Encoder.GetBytes($setPW)
    if(($securityInterface.SetBiosPassword(1,$setPW.length,$bytes,$password)).status -eq 0)
  {
    Write-output -Value "$password.Password is set"
  }
    else{
        Write-Output -Name "($password.password exist)" -value "falied"
    } 
  }  
  #set new BIOS PAssword   
  else {
   if(($securityInterface.SetBiosPassword(0,0,$setpw, "" ,$password)).status -eq 0)
   {
       Write-Output -Value "$password.Password is set"
     else{
       Write-Output -Name "($password.password exist)" -value "failed"
     }
   }
  }