# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Get all VMs
$vms = Get-VM

# Loop through all VMs
foreach ($vm in $vms) {
    # Check if the VM name is not "VCENTER-HOSTNAME"
    if ($vm.Name -ne "VCENTER-HOSTNAME") {
        # Gracefully shut down the VM
        Stop-VM -VM $vm -Confirm:$false -RunAsync
    }
}

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)

  .DESCRIPTION
  Massive-Shutdown.ps1 - ver 1.0.0
  This script shuts down every VM it founds on the vCenter, except the vCenter itself.
  The vCenter name should be changed to match your environment.

  .INPUTS
  None. You cannot pipe objects to Massive-Shutdown.ps1.

  .OUTPUTS
  Massive-Shutdown.ps1 shuts down every VM except the one named VCENTER-HOSTNAME (the vCenter).

  .EXAMPLE
  PS> .\Massive-Shutdown.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  Remember to change the string "VCENTER-HOSTNAME" to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
