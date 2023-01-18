# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 18/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Initialize an empty array to store snapshots
$snapshots = @()

# Get all VMs
$vms = Get-VM

# Iterate through all VMs
foreach ($vm in $vms) {
    # Get all snapshots of each VM
    $vm_snapshots = Get-Snapshot -VM $vm
    # Add the snapshots to the array
    $snapshots += $vm_snapshots
}

# Define the table style
$style = "<style>table,th,td{border:1px solid black;font-family: 'Consolas';}</style>"

# Select the VM, Snapshot Name, Snapshot description, Creation date, and Age (in days) of each snapshot
# Use the New-TimeSpan cmdlet to calculate the difference between the snapshot creation date and the current date, the resulting value is in days
# Convert the snapshots array into an HTML table
$snapshots_table = $snapshots | Select-Object VM, Name, Description, Created, @{Name="Age (in days)"; Expression={(New-TimeSpan -Start $_.Created -End (Get-Date)).Days}} | ConvertTo-Html -Fragment -As Table -PreContent $style

# Output the table to an HTML file
$snapshots_table | Out-File "snapshots_report.html"

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 18/01/2023 (https://openai.com/)

  .DESCRIPTION
  Snapshots-Report.ps1 - ver 1.0.0
  This script retrieves a list of all the existing snapshots and other infos about them.
  It then outputs everything on a nicely formatted HTML table.

  .INPUTS
  None. You cannot pipe objects to Snapshots-Report.ps1.

  .OUTPUTS
  Snapshots-Report generates an output file named snapshots_report.html in the current directory.

  .EXAMPLE
  PS> .\Snapshots-Report.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
