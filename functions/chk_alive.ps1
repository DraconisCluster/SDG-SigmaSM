function Check_Alive {
    $procs_alive = Get-WmiObject Win32_Process | Select-Object CommandLine | findstr -i $GameServerExe | findstr -i $GALAXY
    If (!($procs_alive)) {
        Start_Server          
        weiner
    }
}
