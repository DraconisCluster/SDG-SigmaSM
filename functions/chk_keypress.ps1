function Check_Keypress ($sleepSeconds = $backuptimeout) {

    $timeout = New-TimeSpan -Seconds $sleepSeconds
    $stopWatch = [Diagnostics.Stopwatch]::StartNew()
    $interrupted = $false

    while ($stopWatch.Elapsed -lt $timeout) {
        if ($Host.UI.RawUI.KeyAvailable) {
            $keyPressed = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyUp, IncludeKeyDown")
            if ($keyPressed.KeyDown -eq "True") { 
                 $interrupted = $true
                 break          
            } 
        }
    }
    return $interrupted
}
