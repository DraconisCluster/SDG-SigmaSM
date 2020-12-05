[string]$global:SSM_path = Get-Location
. $SSM_path\config\SigmaSM.settings.ps1
[string]$funcs = Get-ChildItem -Path $SSM_path\functions -Exclude games
$funclist = $funcs.split(" ")
foreach($func in $funclist){ . $func }
Banner
Menu
Write-Output "$($menu_response.toUpper())"
Switch ($($menu_response.toUpper()))
{
    1 {
        . $SSM_path\config\Profile.AVDS01.config.ps1
        . $SSM_path\config\Profile.AVDS01.secret.ps1
        [string]$global:game_funcs = Get-ChildItem -Path $SSM_path\functions\games\$game
        $game_funclist = $game_funcs.split(" ")
        foreach($game_func in $game_funclist){ 
            Write-Host "Loading $SSM_path\functions\games\$game\$game_func"
            . $SSM_path\functions\games\$game\$game_func 
        }
    }
    Q {
        Write-Host "B:::::::::::::::::::::::::::::::::::::D I POOP IN YOUR GENERAL DIRECTION!!!!"
        exit;
    }
}

# Ensure we aren't running with a shortented delay.
$restart_orig = $restart_delay

Check_Clock  # Exits if the clock is off by more than 30 seconds.

# Main loop
Timers 
while ($true) {
    Check_Alive
    Check_Restart
    Check_Update
    Check_Status
    write-host "~" -nonewline
    Start-Sleep -Seconds $loop_delay
}
