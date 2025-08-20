# Network Enumeration Tool

**Network Enumeration Tool**, is a comprehensive PowerShell script designed to perform both user and network enumeration on a Windows system, saving all results into a well-organized and elegant HTML report. This tool is useful for both security experts and system administrators who need detailed insights into their network and system configurations, user activities, and security settings.

## Key Features

This tool comes packed with an extensive set of features, ensuring that nothing about your network environment goes unnoticed. Here's what it can do for you:

### 1. User Enumeration

- **Current Username**: Captures and displays the current logged-in user.
- **User Privileges**: Lists the privileges of the current user, making it easy to determine what level of access they have.
- **All Local Users**: Provides a list of all local users, including their status and last logon time.
- **Logon Requirements**: Gathers details about system logon requirements, including password policies and expiration settings.
- **Detailed User Information**: Offers in-depth information about specified users such as `administrator` and the current user.
- **Local Groups**: Enumerates all local groups on the system, along with the members of key groups like `Administrators`.

### 2. Network Enumeration

- **Network Interfaces**: Lists all network interfaces, including their IP addresses and DNS configurations, to give a complete overview of available network connections.
- **Routing Table**: Displays the current IPv4 routing table, showing the destination, next hop, and metrics to help analyze the routing behavior.
- **ARP Table**: Lists ARP (Address Resolution Protocol) entries, allowing for easy identification of connected devices.
- **Current Connections**: Displays all current TCP connections and their associated process IDs, allowing you to monitor network activity.
- **Network Shares**: Lists all shared resources on the system, including default shares, to determine the level of access exposure.
- **SNMP Configuration**: Retrieves SNMP settings from the registry to assess monitoring configurations.

### 3. Security and Forensics Features

- **Event Log Analysis**: Retrieves the most recent events from the System Event Log to help detect suspicious activities and identify potential threats.
- **Active Network Sessions**: Lists active network sessions to determine who is actively connected to the system, useful for identifying unauthorized access.
- **Firewall Configuration**: Shows the current Windows firewall settings, helping you to verify if proper protections are in place.
- **Scheduled Tasks**: Lists all scheduled tasks on the system to help detect persistence mechanisms often used by attackers.
- **Open Ports and Listening Services**: Displays information about open ports and listening services, allowing you to identify potential points of entry for an attacker.
- **Audit Policy Configuration**: Captures the audit policy settings to verify what actions are being logged for security purposes.

### 4. System Insights

- **Network Adapter Details**: Provides comprehensive details on all network adapters, including MAC addresses and link speed.
- **Installed Software**: Lists all installed software on the system, making it easy to spot unauthorized or suspicious programs.
- **Service Enumeration**: Enumerates all services running on the system, allowing the identification of unwanted or malicious services.
- **Process Enumeration**: Lists all currently running processes, useful for identifying malicious activity or unauthorized software.
- **DNS Cache Enumeration**: Displays the DNS cache to help analyze recent connections and identify any suspicious domain lookups.

### 5. Comprehensive Reporting

All the data gathered during enumeration is saved to a beautifully formatted HTML report, complete with:

- **Minimalistic, Modern Design**: The HTML report is crafted to look clean and modern, making it easy to read and interpret data.
- **Detailed Tables and Sections**: Data is presented in clear sections and tables, ensuring that every aspect of the enumeration is easy to navigate.
- **SHA-256 Hash of the Report**: To ensure integrity, the report includes a SHA-256 hash, allowing you to verify that the report hasn't been tampered with.

## Usage Instructions

To use this tool, save the script as a `.ps1` file and run it from PowerShell with administrative privileges. Running the script as an administrator is essential, as many of the commands require elevated permissions.

1. Open PowerShell as an administrator.
2. Set the execution policy if needed to allow the script to run:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Run the script:
   ```powershell
   .\NetworkEnumerationScript.ps1
   ```

The script will generate an HTML report called `Network_Enumeration_Report.html` in the current directory, containing all the gathered data.

## Requirements

- **PowerShell Version**: The script uses modern cmdlets and should be run on PowerShell 5.1 or later.
- **Administrator Privileges**: Many of the commands require administrative rights to access user, network, and system information.

## Disclaimer

This tool is intended for use by system administrators, security professionals, and forensics experts. Unauthorized use of this script on systems you do not own or manage may be illegal. Use responsibly and ensure you have permission to run these checks on the target system.

## Contributions

Contributions are welcome! If you'd like to enhance this tool, feel free to submit a pull request or open an issue on GitHub. We are particularly interested in adding more security-focused features and improving the forensic capabilities of the tool.

## License

This project is open-source and available under the MIT License. Feel free to use, modify, and distribute it as per the terms of the license.

---

**Stay Secure.**

Crafted with care to help system administrators and security professionals ensure their network is fully visible, secure, and compliant.

