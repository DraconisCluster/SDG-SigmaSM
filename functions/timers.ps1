function timers {
    $global:restart_timer = [diagnostics.stopwatch]::StartNew()
    $global:update_timer = [diagnostics.stopwatch]::StartNew()
    $global:status_timer = [diagnostics.stopwatch]::StartNew()
}
function timer_loop_reset {
    $restart_timer.Restart()
    $update_timer.Restart()
    $global:restart_10_done = 0
    $global:restart_5_done = 0
    $global:restart_1_done = 0
    $global:restart_stop_done = 0
    $global:update_chk_done = 0
}
