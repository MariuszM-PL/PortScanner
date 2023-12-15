# Port Scanner

This PowerShell script allows you to check the availability of ports on a specified device in the network. The script provides various scanning options, allowing you to scan a single port, all ports in a range, or the full range of ports.

## Table of Contents

- [Usage](#usage)
- [Options](#options)
- [File Descriptions](#file-descriptions)
- [Contributing](#contributing)
- [License](#license)

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/port-scanner.git
1. Open PowerShell and navigate to the script directory:
   ```bash
    cd path/to/port-scanner
2. Run the script:
   ```bash
   .\PortScanner.ps1

## Options
The script provides the following scanning options:

Scan (Single Port): Scan a specific port on the target device.
Fullscan (1-65535): Scan all ports in the range from 1 to 65535.
Range (xxxxx-xxxxx): Scan a specified range of ports.

## File Descriptions
PortScanner.ps1: The main PowerShell script for port scanning.
Ports.txt: The file where the raw output of port scanning is saved.
OpenPorts.txt: The file where information about open ports is saved.

## Contributing
If you would like to contribute to this project, feel free to open an issue or submit a pull request. Your feedback and contributions are highly appreciated!

## License
This project is licensed under the MIT License.
