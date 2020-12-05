function Check_Restart {

    $restart_10 = $restart_delay - 10
    $restart_5 = $restart_delay - 5
    $restart_1 = $restart_delay - 1

    if ($restart_timer.Elapsed.TotalMinutes -ge $restart_10 -and $global:restart_10_done -ne "1") {
        timestamp
        Write-Host "Restarting in 10 minutes!!"
        discord_webhook "Restarting in 10 minutes!!"
        rcon -action say -arg "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! - Restarting in 10 minutes - ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
        rcon -action save
        weiner
        $global:restart_10_done = "1"
    } 

    ElseIf ($restart_timer.Elapsed.TotalMinutes -ge $restart_5 -and $global:restart_5_done -ne "1") {
        timestamp
        Write-Host "Restarting in 5 minutes!!"
        rcon -action say -arg "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! - Restarting in 5 minutes - ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
        rcon -action save
        weiner
        $global:restart_5_done = "1"
    } 
    
    ElseIf ($restart_timer.Elapsed.TotalMinutes -ge $restart_1 -and $global:restart_1_done -ne "1") {
        timestamp
        Write-Host "Restarting in 1 minute!!"
        discord_webhook "Restarting in 1 minute!!"
        rcon -action say -arg "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! - Restarting in 1 minutes - ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
        rcon -action save
        weiner
        $global:restart_1_done = "1"
    }

    ElseIf ($restart_timer.Elapsed.TotalMinutes -ge $restart_delay -and $global:restart_stop_done -ne "1") {
        timestamp
        Write-Host "Restarting now!!!"
        rcon -action say -arg "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! - Restarting NOW!! - ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
        rcon -action save
        weiner
        $global:restart_stop_done = "1"
        Stop_Server
    }

}
