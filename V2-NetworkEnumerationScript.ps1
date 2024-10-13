$outputPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Network_Enumeration_Report.html')

$htmlHeader = @"
<html>
<head>
    <title>Network Enumeration Report</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1, h2, h3 {
            color: #0078d4;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #0078d4;
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        pre {
            background-color: #282c34;
            color: #61dafb;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            font-size: 0.9em;
        }
        .section {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
<div class="container">
<h1>Network Enumeration Report</h1>
<h3>Made with <3 by samridhx0</h3>
"@
$htmlHeader | Out-File -FilePath $outputPath

# User Enumeration
Add-Content -Path $outputPath -Value "<div class='section'><h2>User Enumeration</h2>"

# Get current username
Add-Content -Path $outputPath -Value "<h3>Current Username</h3><pre>"
$username = whoami
$username | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# List user privileges
Add-Content -Path $outputPath -Value "<h3>User Privileges</h3><pre>"
$userPrivileges = whoami /priv
$userPrivileges | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# List all users
Add-Content -Path $outputPath -Value "<h3>All Users</h3><table><tr><th>Name</th><th>Enabled</th><th>Last Logon</th></tr>"
$allUsers = Get-LocalUser
foreach ($user in $allUsers) {
    Add-Content -Path $outputPath -Value "<tr><td>$($user.Name)</td><td>$($user.Enabled)</td><td>$($user.LastLogon)</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# List logon requirements
Add-Content -Path $outputPath -Value "<h3>Logon Requirements</h3><pre>"
$logonRequirements = net accounts
$logonRequirements | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Get details about a user
Add-Content -Path $outputPath -Value "<h3>Details About Users</h3><pre>"
$adminDetails = net user administrator
$adminDetails | Out-String | Add-Content -Path $outputPath

$currentUserDetails = net user $env:username
$currentUserDetails | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# List all local groups
Add-Content -Path $outputPath -Value "<h3>Local Groups</h3><table><tr><th>Name</th></tr>"
$localGroups = Get-LocalGroup
foreach ($group in $localGroups) {
    Add-Content -Path $outputPath -Value "<tr><td>$($group.Name)</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# Get details about a group
Add-Content -Path $outputPath -Value "<h3>Details About Administrators Group</h3><table><tr><th>Name</th><th>Principal Source</th></tr>"
$groupDetails = Get-LocalGroupMember -Group "Administrators"
foreach ($member in $groupDetails) {
    Add-Content -Path $outputPath -Value "<tr><td>$($member.Name)</td><td>$($member.PrincipalSource)</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# Network Enumeration
Add-Content -Path $outputPath -Value "<h2>Network Enumeration</h2>"

# List all network interfaces, IP, and DNS
Add-Content -Path $outputPath -Value "<h3>Network Interfaces, IP, and DNS</h3><table><tr><th>Interface Alias</th><th>Interface Description</th><th>IPv4 Address</th></tr>"
$networkInterfaces = Get-NetIPConfiguration
foreach ($interface in $networkInterfaces) {
    $ipAddress = ($interface.IPv4Address | Select-Object -First 1).IPAddress
    Add-Content -Path $outputPath -Value "<tr><td>$($interface.InterfaceAlias)</td><td>$($interface.InterfaceDescription)</td><td>$ipAddress</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# List current routing table
Add-Content -Path $outputPath -Value "<h3>Routing Table</h3><table><tr><th>Destination Prefix</th><th>Next Hop</th><th>Route Metric</th><th>Interface Index</th></tr>"
$routingTable = Get-NetRoute -AddressFamily IPv4
foreach ($route in $routingTable) {
    Add-Content -Path $outputPath -Value "<tr><td>$($route.DestinationPrefix)</td><td>$($route.NextHop)</td><td>$($route.RouteMetric)</td><td>$($route.ifIndex)</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# List the ARP table
Add-Content -Path $outputPath -Value "<h3>ARP Table</h3><table><tr><th>Interface Index</th><th>IP Address</th><th>Link Layer Address</th><th>State</th></tr>"
$arpTable = Get-NetNeighbor -AddressFamily IPv4
foreach ($neighbor in $arpTable) {
    Add-Content -Path $outputPath -Value "<tr><td>$($neighbor.ifIndex)</td><td>$($neighbor.IPAddress)</td><td>$($neighbor.LinkLayerAddress)</td><td>$($neighbor.State)</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# List all current connections
Add-Content -Path $outputPath -Value "<h3>Current Connections</h3><pre>"
$currentConnections = netstat -ano
$currentConnections | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# List all network shares
Add-Content -Path $outputPath -Value "<h3>Network Shares</h3><table><tr><th>Share Name</th><th>Resource</th><th>Remark</th></tr>"
$networkShares = net share | Select-String "^(?<ShareName>\S+)\s+(?<Resource>\S*)\s+(?<Remark>.*)$"
foreach ($share in $networkShares.Matches) {
    Add-Content -Path $outputPath -Value "<tr><td>$($share.Groups['ShareName'])</td><td>$($share.Groups['Resource'])</td><td>$($share.Groups['Remark'])</td></tr>"
}
Add-Content -Path $outputPath -Value "</table>"

# SNMP Configuration
Add-Content -Path $outputPath -Value "<h3>SNMP Configuration</h3><pre>"
$snmpConfig = Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\SNMP -Recurse
$snmpConfig | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Detailed Event Log Analysis
Add-Content -Path $outputPath -Value "<h3>Event Log Analysis</h3><pre>"
$eventLogs = Get-WinEvent -LogName System -MaxEvents 50
$eventLogs | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Active Network Sessions
Add-Content -Path $outputPath -Value "<h3>Active Network Sessions</h3><pre>"
$activeSessions = net session
$activeSessions | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Firewall Configuration
Add-Content -Path $outputPath -Value "<h3>Firewall Configuration</h3><pre>"
$firewallConfig = netsh advfirewall show allprofiles
$firewallConfig | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Network Adapter Details
Add-Content -Path $outputPath -Value "<h3>Network Adapter Details</h3><pre>"
$networkAdapters = Get-NetAdapter
$networkAdapters | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Process Enumeration
Add-Content -Path $outputPath -Value "<h3>Process Enumeration</h3><pre>"
$processes = Get-Process
$processes | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Scheduled Tasks
Add-Content -Path $outputPath -Value "<h3>Scheduled Tasks</h3><pre>"
$scheduledTasks = Get-ScheduledTask
$scheduledTasks | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Service Enumeration
Add-Content -Path $outputPath -Value "<h3>Service Enumeration</h3><pre>"
$services = Get-Service
$services | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Open Ports and Listening Services
Add-Content -Path $outputPath -Value "<h3>Open Ports and Listening Services</h3><pre>"
$openPorts = Get-NetTCPConnection -State Listen
$openPorts | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# DNS Cache Enumeration
Add-Content -Path $outputPath -Value "<h3>DNS Cache</h3><pre>"
$dnsCache = ipconfig /displaydns
$dnsCache | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Installed Software
Add-Content -Path $outputPath -Value "<h3>Installed Software</h3><pre>"
$installedSoftware = Get-WmiObject -Class Win32_Product
$installedSoftware | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Audit Policy Configuration
Add-Content -Path $outputPath -Value "<h3>Audit Policy Configuration</h3><pre>"
$auditPolicy = AuditPol /get /category:*
$auditPolicy | Out-String | Add-Content -Path $outputPath
Add-Content -Path $outputPath -Value "</pre>"

# Close HTML tags
Add-Content -Path $outputPath -Value "</div></body></html>"

# Generate a hash of the report
$hash = Get-FileHash -Path $outputPath -Algorithm SHA256
$hashOutput = "<div class='section'><h2>Report Hash</h2><pre>SHA256: $($hash.Hash)</pre></div>"
Add-Content -Path $outputPath -Value $hashOutput

# Notify user
Write-Output "Network Enumeration Report saved to $outputPath"
