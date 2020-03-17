$name = Read-Host "Enter task name";
Write-Host "";
$time = Read-Host "Enter task execution time";
Write-Host "";
$user = Read-Host "Enter user name";
Write-Host "";
$file = Read-Host "Enter file";
Write-Host "";
$argument = Read-Host "Enter arguments (optional)";
Write-Host "";
if ($name.Length -lt 1 -or $time.Length -lt 1 -or $user.Length -lt 1 -or $file.Length -lt 1) {
	Write-Host "Required parameters are missing";
} else {
	try {
		$exists = Get-ScheduledTask | Where-Object { $_.TaskName -eq $name };
		if ($exists -eq $true) {
			Write-Host "Scheduled task already exists";
		} else {
			$trigger = New-ScheduledTaskTrigger -At $time -Once;
			$action = $null;
			if ($argument -eq "") {
				$action = New-ScheduledTaskAction -Execute $file;
			} else {
				$action = New-ScheduledTaskAction -Execute $file -Argument $argument;
			}
			$result = Register-ScheduledTask -TaskName $name -Trigger $trigger -User $user -Action $action -Force | Out-Null;
			Write-Host "Scheduled task was added successfully";
		}
	} catch {
		Write-Host $_.Exception.InnerException.Message;
	}
}
