# Checks before you run this script
Get-CimInstance -Namespace root/WMI -ClassName Lenovo_BiosPasswordSettings
#Run the commands to set initial Supervisor Password and replace it
$setPW = Get-WmiObject -Namespace root/WMI -class Lenovo_SetBiosPassword
#
$setPW.SetBioPassword ("pap,secretpassword,secretpassword,ascii,us")

Function New-LenovoSetBIOSPassword 
{
   param(
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Namespace,
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$ClassName   
        )
}

       