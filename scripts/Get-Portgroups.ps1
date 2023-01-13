# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Get all VDs and their portgroups
$vdswitches = Get-VDSwitch

foreach ($vdswitch in $vdswitches) {
    $vds = Get-VDPortgroup -VDSwitch $vdswitch.Name
    $html += "<h2>$($vdswitch.Name)</h2>"
    $html += "<table border='1' style='font-family: Consolas;'><tr><th>Portgroup Name</th></tr>"
    foreach ($vd in $vds) {
        $html += "<tr><td>$($vd.Name)</td></tr>"
    }
    $html += "</table><br>"
}

# Output HTML
$html | Out-File -FilePath portgroups_list.html -Encoding UTF8

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)

  .DESCRIPTION
  Get-Portgroups.ps1 - ver 1.0.0
  This script retrieves the list of the portgroups for each vDS.
  It then outputs everything on a nicely formatted HTML table.

  .INPUTS
  None. You cannot pipe objects to Get-Portgroups.ps1.

  .OUTPUTS
  Get-Portgroups.ps1 generates an output file named portgroups_list.html in the current directory.

  .EXAMPLE
  PS> .\Get-Portgroups.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
