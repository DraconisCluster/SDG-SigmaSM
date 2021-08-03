function Check_Clock ($MaxOffset = 90000, $NTPServer = "time.nist.gov") {
    # Check Time
    . "$SSM_path\scripts\Get-NtpTime.ps1"
    Write-Host "Ensuring the correct server time..."
    Try {
        (Get-NtpTime -MaxOffset $MaxOffset -Server $NTPServer).NtpTime
    }
    Catch {
        Write-Host "Server could not be started because of an issue with the server clock:"
        Write-Host "$_"
        Write-Host -NoNewLine 'Press any key to exit...';
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
        exit
    }
}
