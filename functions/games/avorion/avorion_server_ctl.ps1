function Start_Server {
    timestamp
    Write-Host "Not running. Starting..."           
    Write-Host "Backup will start in $backuptimeout seconds. Press any key to skip backup and start server."
    if (Check_Keypress) {
        timestamp
        Write-Host "Skipping Backup!"
        Write-Host "Starting Server..."
        discord_webhook "Starting Server..."
        # Start Avorion Server
        Set-Location "$game_dir\avorionserver\"
        & $steamcmd +login anonymous +force_install_dir "$game_dir\avorionserver" +app_update 565060 -beta beta +quit
        Start-Process -FilePath $game_path -ArgumentList $game_args
    } else {
        # Execute the Backup
        timestamp
        Write-Host "Backing up, pwease wait..."
        . $SSM_path\scripts\Backup.ps1
        timestamp
        Write-Host "Starting Server..."
        discord_webhook "Starting Server..."
        # Start Avorion Server
        Set-Location "$game_dir\avorionserver\"
        & $steamcmd +login anonymous +force_install_dir "$game_dir\avorionserver" +app_update 565060 -beta beta +quit
        Start-Process -FilePath $game_path -ArgumentList $game_args
    }
    $global:restart_delay = $restart_orig
    timer_loop_reset
}

function Stop_Server {
    timestamp
    Write-Host "Stopping Server..."
    discord_webhook "Stopping Server..."
    weiner
    rcon -action say -arg "Stopping Server..."
    rcon -action stop
    timer_loop_reset
}
