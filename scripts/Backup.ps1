# Generic Offline backup with GFS rotation.
# Authors: DeMiNe0

. "$SSM_path\config\Backup.$SSM_Profile.config.ps1"

# Sets the process priority to lower and pins it to 2 cores
$process = Get-Process -id $pid
$Orig_PriorityClass = $process.PriorityClass
$Orig_ProcessorAffinity = $process.ProcessorAffinity
$process.PriorityClass = "BelowNormal"
$process.ProcessorAffinity = 0x0003

# 7Zip files
$arguments = '-mx=1'
$in = "$inputdir\$inputfiles"
$out = $stagedir + '\' + $filename + '_' + $datestamp + '.7z'

&$7zip a $arguments $out $in # For Live
#&fsutil file createnew $out 12288 # For testing

Write-Host "Organizing and Rotating backups..."

$verify_files_dir = Test-Path $remotedir

if ($verify_files_dir) {
	$verify_daily_dir = Test-Path "$remotedir\daily"
	$verify_weekly_dir = Test-Path "$remotedir\weekly"
	$verify_monthly_dir = Test-Path "$remotedir\monthly"
	$verify_staging = Test-Path "$stagedir"
	$verify_outputdir = Test-Path "$outputdir"

	if (!$verify_staging) {
		$md_daily = md $stagedir
		if (!$md_staging) {
			Write-Host "Error setting up Stage directories. Check Permissions."
			exit
		}
	}
	if (!$verify_outputdir) {
		$md_outputdir = md $outputdir
		if (!$md_outputdir) {
			Write-Host "Error setting up output directory. Check Permissions."
			exit
		}
	}
	# If the daily directory does not exist try to create it
	if (!$verify_daily_dir) {
		$md_daily = md -Name "daily" -Path $remotedir
		if (!$md_daily) {
			Write-Host "Error setting up files directories. Check Permissions."
			exit
		}
	}
	# If the weekly directory does not exist try to create it
	if (!$verify_weekly_dir) {
		$md_weekly = md -Name "weekly" -Path $remotedir
		if (!$md_weekly) {
			Write-Host "Error setting up files directories. Check Permissions."
			exit
		}
	}
	# If the monthly directory does not exist try to create it
	if (!$verify_monthly_dir) {
		$md_monthly = md -Name "monthly" -Path $remotedir
		if (!$md_monthly) {
			Write-Host "Error setting up files directories. Check Permissions."
			exit
		}
	}
}
else {
	Write-Host "Error:  Remote directory $remotedir does not exist or is not accessable."
	exit
}

$files_root = Get-ChildItem $stagedir | where { $_.Attributes -ne "Directory" }

if ($files_root) {
	
	# Organizing Files

	# Are the GFS backups allready made?
	$rot_chk_w = Get-ChildItem "$remotedir\weekly\*$srtdatestamp*"
	$rot_chk_m = Get-ChildItem "$remotedir\monthly\*$srtdatestamp*"
	$rot_chk_d = Get-ChildItem "$remotedir\daily\*$srtdatestamp*"

	foreach ($file in $files_root) {
		$file_date = get-date $file.LastWriteTime
		[string]$file_date_DayOfWeek = [string]$file_date.DayOfWeek
		if ([string]$file_date_DayOfWeek.ToLower() -eq [string]$DayOfWeek.ToLower() -and [string]::IsNullOrWhiteSpace($rot_chk_w)) {
			Write-Host "Making Weekly Remote Copy: $($file.Name) - $($file_date) - $($file_date.DayOfWeek)"	
			Copy-Item "$stagedir\$file" "$remotedir\weekly"
		}
		if ([int]$file_date.Day -eq $DayOfMonth -and [string]::IsNullOrWhiteSpace($rot_chk_m)) {
			Write-Host "Making Monthly Remote Copy: $($file.Name) - $($file_date)"
			Copy-Item "$stagedir\$file" "$remotedir\monthly"
		}
		if ([string]::IsNullOrWhiteSpace($rot_chk_d)) {
			Write-Host "Making Daily Remote Copy: $($file.Name) - $($file_date)"
			Copy-Item "$stagedir\$file" "$remotedir\daily"
		}
		Move-Item "$stagedir\$file" "$outputdir\" -force
	}
	
	$files_daily_local = Get-ChildItem "$outputdir" | where { $_.Attributes -ne "Directory" } | Sort-Object LastWriteTime -Descending
	$files_daily = Get-ChildItem "$remotedir\daily" | where { $_.Attributes -ne "Directory" } | Sort-Object LastWriteTime -Descending
	$files_weekly = Get-ChildItem "$remotedir\weekly" | where { $_.Attributes -ne "Directory" } | Sort-Object LastWriteTime -Descending
	$files_monthly = Get-ChildItem "$remotedir\monthly" | where { $_.Attributes -ne "Directory" } | Sort-Object LastWriteTime -Descending

	# Pruning Files

	if ($files_daily) {
		foreach ($file in $files_daily) {
			$file_date = get-date $file.LastWriteTime
			if ($file_date -le $Now.AddDays(-$RotationDaily)) {
				Write-Host "Removing $file.Name due to rotation."
				Remove-Item "$remotedir\daily\$file"                    
			}
		}
	}
	if ($files_daily_local) {
		foreach ($file in $files_daily) {
			$file_date = get-date $file.LastWriteTime
			if ($file_date -le $Now.AddDays(-$RotationDaily)) {
				Write-Host "Removing $file.Name due to rotation."
				Remove-Item "$outputdir\$file"                    
			}
		}
	}
	if ($files_weekly) {
		foreach ($file in $files_weekly) {
			$file_date = get-date $file.LastWriteTime
			if ($file_date -le $Now.AddDays(-$RotationWeekly * 7)) {
				Write-Host "Removing $file.Name due to rotation."
				Remove-Item "$remotedir\weekly\$file"
			}
		}
	}
	if ($files_monthly) {
		foreach ($file in $files_monthly) {
			$file_date = get-date $file.LastWriteTime
			if ($file_date -le $Now.AddDays(-$RotationMonthly * 30)) {
				Write-Host "Removing $file.Name due to rotation."
				Remove-Item "$remotedir\monthly\$file"
			}
		}
	}
	Write-Host "Removing anything older than the last RotationDailyMax ($RotationDailyMax) files from local locations..."
	Get-ChildItem "$outputdir" | where { -not $_.PsIsContainer } | sort CreationTime -desc | select -Skip $RotationDailyMax | Remove-Item -Force -Verbose
}

# Unsets the process priority to so any child process (like a game server) has full utilization of the cores
$process = Get-Process -id $pid
$process.PriorityClass = $Orig_PriorityClass
$process.ProcessorAffinity = $Orig_ProcessorAffinity
