function Menu {
    [string]$menu = @"

    Select the Profile you want to launch with:
    Default will be choosen after 10 seconds if no action is taken.
    ---------------------------------------------------------------
        1. Avorion [Profile: AVDS01] (Default)                                                                                                                                
        Q. Quit (you pussy)                                                                                                                                

"@   
    $startTime = Get-Date
    $timeOut = New-TimeSpan -Seconds $menutimeout
    Write-Host $menu
    while (-not $host.ui.RawUI.KeyAvailable) {
        $currentTime = Get-Date
        if ($currentTime -gt $startTime + $timeOut) {
            Break
        }
    }
    if ($host.ui.RawUI.KeyAvailable) {
        [string]$global:menu_response = ($host.ui.RawUI.ReadKey("IncludeKeyDown,NoEcho")).character
    } else {
        [string]$global:menu_response = $menudefault
    }
}