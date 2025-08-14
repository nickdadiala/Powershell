function RefreshEdgePage {
    # Get the Microsoft Edge process
     = Get-Process -Name msedge -ErrorAction SilentlyContinue
    # If the Edge process is running
    if () {
        # Try to activate the Edge window using the title
         = Get-Process -Name msedge | Where-Object { .MainWindowTitle -ne "" } | Select-Object MainWindowTitle -First 1
        if () {
             = New-Object -ComObject WScript.Shell
            .AppActivate(.MainWindowTitle)
            Start-Sleep -Seconds 1 # Wait for a second to ensure Edge is active
            .SendKeys('{F5}')
            Start-Sleep -Seconds 2
            .SendKeys('{F11}') 
            {
               Write-Host "unable to find the Microsoft Edge"
            } else {
               Write-Host "Microsoft Edge is not running"
          }
        }
# Define the time interval in seconds (5 seconds)
 = 30
# Execute the action at each time interval
while (True) {
    RefreshEdgePage
    Start-Sleep -Seconds 
}
