# Displaying a separator
Write-Host "====================================" -ForegroundColor Yellow
# Displaying information about port checking
Write-Host "*PORT CHECK*" -ForegroundColor Yellow
# Displaying a separator
Write-Host "====================================" -ForegroundColor Yellow

# Getting the computer name
$pc = hostname

# Definition of a function for formatting the Ports.txt file
function FormatPorts
{
    # Displaying a message about starting the formatting of the Ports.txt file
    Write-Host "Started formatting the Ports.txt file..." -ForegroundColor Yellow
    # Processing the content of the Ports.txt file
    $split = foreach($line in Get-Content \\$pc\C$\Ports.txt) {
        if($line -match ":Host"){
            $line = $line.split(":")[1]
        }
        write-output $line
    }

    # Saving the processed content to the file
    $split | Out-File -FilePath \\$pc\C$\Ports.txt
    Write-Host "Finished formatting the Ports.txt file..." -ForegroundColor Green

    # Displaying a message about saving information about open ports to the OpenPorts.txt file
    Write-Host "Saving information about open ports to the OpenPorts.txt file..." -ForegroundColor Yellow
    # Filtering open ports
    $result = foreach($line in Get-Content \\$pc\C$\Ports.txt) {
        if($line -match "Status: True"){
            write-output $line
        }
    }

    # Saving information about open ports to the OpenPorts.txt file
    $result | Out-File -FilePath \\$pc\C$\OpenPorts.txt
    Write-Host "Saved information about open ports to the OpenPorts.txt file. Check the saved file!" -ForegroundColor Green
}

# Requesting the IP address of the device
Write-Host "Enter the IP address of the device" -ForegroundColor Green
$ip = Read-Host "IP: "

$port = $null

# Displaying port scanning options
Write-Host "1. Scan (Single Port)" -ForegroundColor Yellow
Write-Host "2. Fullscan (1-65535)" -ForegroundColor Yellow
Write-Host "3. Range (xxxxx-xxxxx)" -ForegroundColor Yellow

# Selecting the port scanning mode
$option = Read-Host "Choose port scanning mode: e.g., 1"

switch($option){
   1 {
        # Requesting the port to scan
        Write-Host "Enter the port you want to scan: " -ForegroundColor Green
        $nr_port = Read-Host "Port: "
        $port = $nr_port

        # Checking the status of the port
        $connection = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ip, $port).Wait(1000)

        $output = if ($connection.Connected) {
            Write-Output "Host: $ip, Port: $port, Status: $connection"
        } else { 
            Write-Output "Host: $ip, Port: $port, Status: $connection" 
        }
        Write-Output "======================================================="

        # Saving the results to the Ports.txt file
        $output | Out-File -FilePath \\$pc\C$\Ports.txt
        Write-Host "PORT CHECK COMPLETED" -ForegroundColor Green
        FormatPorts
     }
   2 {
        # Displaying a message about checking all ports
        Write-Host "CHECKING ALL PORTS... PLEASE WAIT!" -ForegroundColor Yellow
        $output = for($port = 1; $port -le 65535; $port++)
        {
            # Checking the status of each port
            $connection = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ip, $port).Wait(1000)
            
            if ($connection.Connected) {
                Write-Output "Host: $ip, Port: $port, Status: $connection"
            } else { 
                Write-Output "Host: $ip, Port: $port, Status: $connection" 
            }
            Write-Output "======================================================="
        }

        # Saving the results to the Ports.txt file
        $output | Out-File -FilePath \\$pc\C$\Ports.txt
        Write-Host "PORT CHECK COMPLETED" -ForegroundColor Green
        FormatPorts
     }
     3
     {
        # Requesting the starting and ending ports for scanning
        Write-Host "Enter the starting port for scanning: " -ForegroundColor Green
        $first_nr_port = Read-Host "Port: "
        $fport = [int]$first_nr_port 

        Write-Host "Enter the last port to end scanning: " -ForegroundColor Green
        $last_nr_port = Read-Host "Port: "
        $lport = [int]$last_nr_port

        # Displaying a message about checking ports in a specified range
        Write-Host "CHECKING PORTS FROM $fport TO $lport... PLEASE WAIT!" -ForegroundColor Yellow
        $output = for($port = $fport; $port -le $lport; $port++)
        {
            # Checking the status of each port
            $connection = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ip, $port).Wait(1000)

            if ($connection.Connected) {
                Write-Output "Host: $ip, Port: $port, Status: $connection"
            } else { 
                Write-Output "Host: $ip, Port: $port, Status: $connection" 
            }
            Write-Output "======================================================="
        }

        # Saving the results to the Ports.txt file
        $output | Out-File -FilePath \\$pc\C$\Ports.txt
        Write-Host "PORT CHECK COMPLETED" -ForegroundColor Green
        FormatPorts
     }
}
