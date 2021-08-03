param (
    [string]$global:SSM_Profile = "AVDS02",
        
    [string]$global:game = "avorion",
    [string]$global:game_dir = "$SSM_path\avorion",
    [string]$global:GameServerExe = "AvorionServer.exe",
    [string]$global:game_path = "$game_dir\avorionserver\bin\$GameServerExe",
    [string]$global:GALAXY = $SSM_Profile,
    [string]$global:game_args = "--galaxy-name $GALAXY --datapath $game_dir\galaxies",
    
    [string]$global:backup = "$SSM_path\scripts\Backup.ps1",
    [int]$global:backuptimeout = 10,  # Number of seconds you have to cancel the backup.

    [int]$global:loop_delay = 10,  # Delay in seconds between loop cycles. Default Safe Range is between 10 and 60.
    [int]$global:restart_delay = 240,  # Delay in minutes between server restarts
    [int]$global:update_delay = 30  # Delay in minutes between automated steamcmd update checks
)
