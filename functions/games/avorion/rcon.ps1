function rcon ($action, $arg) {
    $galaxycfg = Get_IniFile $game_dir\galaxies\$GALAXY\server.ini
    $rcon_port = $galaxycfg.Networking.rconPort
    $rcon_pass = $galaxycfg.Networking.rconPassword
    $rcon_host = "51.81.154.230"
    Switch ($action)
    {
        stop {
            timestamp
            Write-Host "rcon: /stop"
            & $mcrcon -H $rcon_host -P $rcon_port -p $rcon_pass "/stop"
        }
        save {
            timestamp
            Write-Host "rcon: /save"
            & $mcrcon -H $rcon_host -P $rcon_port -p $rcon_pass "/save"
        }
        say {
            timestamp
            Write-Host "rcon: /say $arg"
            & $mcrcon -H $rcon_host -P $rcon_port -p $rcon_pass "/say $arg"
        }
    }
}
