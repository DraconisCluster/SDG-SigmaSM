param (
    [string]$global:steamcmd = "$SSM_path\steamcmd\steamcmd.exe",
    [string]$global:version = "1.0",
    [int]$global:menutimeout = 10,  # Timeout in seconds before default options is picked from the menu. Figure it out yourself to disable.
    [int]$global:status_delay = 15,  # Delay in minutes between console status updates.
    [string]$global:mcrcon = "$SSM_path\bin\mcrcon.exe",
    [string]$global:menudefault = '1'  # The default option that the main menu chooses on timeout. (see functions/Menu.ps1)
)
