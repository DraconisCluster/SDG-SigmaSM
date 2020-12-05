function Check_Status {
    if ($status_timer.Elapsed.TotalMinutes -ge $status_delay) {
        $time_till_restart = $restart_delay - $restart_timer.Elapsed.TotalMinutes
        $time_till_updatechk = $update_delay - $update_timer.Elapsed.TotalMinutes
        timestamp
        Write-Host "Next Restart: $time_till_restart Minutes | Next Update Check: $time_till_updatechk Minutes" 
        weiner
        $status_timer.Restart()    
    } 
}
