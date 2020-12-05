
$global:inputdir = "$game_dir\galaxies\AVDS01"  # Directory to be backed up.
$global:inputfiles = "*"  # Exact name or wildcard match for files in that director.
$global:stagedir = "$game_dir\backups\temp"  # Output Directory for backup archives
$global:outputdir = "$game_dir\backups\archives"  # Output Directory for backup archives
$global:remotedir = "$game_dir\backups\remote"  # This is the remote(off machine) Directory to store backup copies in.
#$global:remotedir = "\\draconis0.sigmadraconis.games\avorion-backups\$SSM_Profile"  # This is the remote(off machine) Directory to store backup copies in.
$global:filename = "AvorionBackup"  # Filename Prefix (without a trailing separator) for Backups

[int]$global:DayOfWeek = 1  # The day of the week to store for weekly files (1 to 7 where 1 is Sunday)
[int]$global:DayOfMonth = 1  # The day of the month to store for monthly files (Max = 28 since varying last day of month not currently handled)

[int]$global:RotationDaily = 7  # The number of daily files to keep (In days)
[int]$global:RotationDailyMax = 10  # The maximum number of local(unrotated) files to keep. It's meant to prevent situations where torch, avorion or something else goes into a restart/backup loop and uses the entire disk for backups.
[int]$global:RotationWeekly = 8  # The number of weekly files to keep
[int]$global:RotationMonthly = 12  # The number of monthly files to keep

$global:Now = Get-Date
$global:datestamp = Get-Date -Format yyyy-MM-dd-HHmmss  # "Datestamp format for backup files"
$global:srtdatestamp = Get-Date -Format yyyy-MM-dd

$global:7zip = "$env:ProgramFiles\7-Zip\7z.exe"
