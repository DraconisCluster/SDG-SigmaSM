function Check_Update {
    if ($update_timer.Elapsed.TotalMinutes -ge $update_delay -and $global:update_chk_done -ne "1") {
        timestamp
        Write-Host "Checking for steam updates..."
        $check_update = & $steamcmd +login anonymous +force_install_dir "$game_dir\avorionserver" +app_update 565060 -beta beta +quit | findstr -i "fully installed."
        If ($check_update) {
            $global:restart_delay = 11
            $restart_timer.Restart()
            timestamp
            Write-Host "Update found, preparing to restart!! Restart countdown and announcements will start in about 1 minute!"
            discord_webhook "Update found, preparing to restart!! Restart countdown and announcements will start in about 1 minute!"
            rcon -action say -arg "! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! - Avorion update available. Server will reboot in 10 minutes! - ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
            $global:update_chk_done = "1"
            weiner
        } else {
            timestamp
            Write-Host "No updates are required."
            weiner
            $update_timer.Restart()
            $global:update_chk_done = "0"
        }
    } 
}
