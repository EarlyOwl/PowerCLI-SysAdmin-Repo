# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 14/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Get a list of all VMs in the vCenter
$vms = Get-VM

# Initialize an empty array to store the report data
$reportData = @()

# Initialize the HTML report with the table header
$html = "<table border='1' style='font-family: Consolas;'><tr><th>Name</th><th>VMware Tools Installed</th><th>Version</th></tr>"

# Loop through each VM and gather the relevant information
foreach ($vm in $vms) {
    $rowColor = ""
    if ($vm.ExtensionData.Guest.ToolsVersion -ne 0) {
        $rowColor = "style='background-color: #61ff69'"
    }
    else {
        $rowColor = "style='background-color: #ff3b3b'"
    }
    $vmInfo = "" | Select-Object Hostname, 'VMware Tools Installed', Version
    $vmInfo.Hostname = $vm.Name
    if ($vm.ExtensionData.Guest.ToolsVersion -ne 0) {
        $vmInfo.'VMware Tools Installed' = "Yes"
        $vmInfo.Version = $vm.ExtensionData.Guest.ToolsVersion
    }
    else {
        $vmInfo.'VMware Tools Installed' = "No"
        $vmInfo.Version = "N/A"
    }
    $html += "<tr $rowColor><td>$($vmInfo.Hostname)</td><td>$($vmInfo.'VMware Tools Installed')</td><td>$($vmInfo.Version)</td></tr>"
}

# Close the table and add the HTML to the report file
$html += "</table>"
$html | Out-File vmware_tools_report.html

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 14/01/2023 (https://openai.com/)

  .DESCRIPTION
  Vmwaretools-Report.ps1 - ver 1.0.0
  This script enumerates all the VMs and verifies whether or not they have Vmware Tools installed (and if so, it checks the current version).
  It then outputs everything on a nicely formatted HTML table.

  .INPUTS
  None. You cannot pipe objects to Vmwaretools-Report.ps1.

  .OUTPUTS
  Vmwaretools-Report.ps1 generates an output file named vmware_tools_report.html in the current directory.

  .EXAMPLE
  PS> .\Vmwaretools-Report.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
