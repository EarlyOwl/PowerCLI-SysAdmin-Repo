# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Get all VMs and their power state, last boot time, and uptime
$vms = Get-VM | ForEach-Object {
    $vm = $_
    $PowerState = $vm.PowerState
    if ($PowerState -eq "PoweredOn") {
        $runtime = (Get-View $vm.Id).Runtime
        $BootTime = $runtime.BootTime
        $Uptime = (Get-Date) - $runtime.BootTime
    } else {
        $BootTime = "N/A"
        $Uptime = "N/A"
    }
    New-Object -TypeName PSObject -Property @{
        Name = $vm.Name
        PowerState = $PowerState
        'Last Boot Time' = $BootTime
        Uptime = $Uptime
    }
}

# Create HTML table with formatted rows and borders
$html = "<table border='1' style='font-family: Consolas;'><tr><th>Name</th><th>Power State</th><th>Last Boot Time</th><th>Uptime</th></tr>"
foreach ($vm in $vms) {
    $rowColor = ""
    if ($vm.PowerState -eq "PoweredOn") {
        $rowColor = "style='background-color: 61ff69'"
    } elseif ($vm.PowerState -eq "PoweredOff") {
        $rowColor = "style='background-color: ff6057'"
    }
    if ($vm.Uptime -ne "N/A") {
        $html += "<tr $rowColor><td>$($vm.Name)</td><td>$($vm.PowerState)</td><td>$($vm.'Last Boot Time')</td><td>$($vm.Uptime.Days) Days $($vm.Uptime.Hours) Hours $($vm.Uptime.Minutes) Minutes</td></tr>"
    } else {
        $html += "<tr $rowColor><td>$($vm.Name)</td><td>$($vm.PowerState)</td><td>$($vm.'Last Boot Time')</td><td>$($vm.Uptime)</td></tr>"
    }
}
$html += "</table>"

# Output HTML table
$html | Out-File -FilePath vm_powerstate.html

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)

  .DESCRIPTION
  Powerstate-Report.ps1 - ver 1.0.0
  This script retrieves the power state, uptime and last boot time of all the VMs.
  It then outputs everything on a nicely formatted HTML table.

  .INPUTS
  None. You cannot pipe objects to Powerstate-Report.ps1.

  .OUTPUTS
  Powerstate-Report.ps1 generates an output file named vm_powerstate.html in the current directory.

  .EXAMPLE
  PS> .\Powerstate-Report.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
