$list = Get-content ./Computer.txt

Import-Csv ./computer.txt
Import-Clixml ./Marketing.xml

# use .net arrays list to collect info
$Arraylist = New-Object "Collection.System.arraylist"
$Arraylist = [System.collection.arraylist]::New()
$Arraylist.remove('DC1-DC2')
$Arraylist.Add('DC4-DC5')
# Build script for .net arraylist looping through all until you get contact with all system.
[System.collection.arraylist]=$computerlist ='DC1,DC2,DC3'
 Do {
    foreach($computerlist in $list){
        if(Test-Connection -ComputerName $computer -Count 1){
          Write-output "$computer is succesfully contacted"
          $computer.remove($computer)
    }
  }
   if($cpmputerlist.count -gt 0){Start-Sleep}
 } Until($computerlist.count -eq 0)
 write-host "$computerlist is contacted succesfully"

 # Change the arraylist for looping and include check or if parameter for validate the connection.
  if($computerlist.Computer) in arraylist establish contact {
    write-output "$comouterlist is established" else 
  } else {
    write-output "$comouterlist is not established"
  }



