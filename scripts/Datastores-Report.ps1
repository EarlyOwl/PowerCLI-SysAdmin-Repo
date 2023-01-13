# Script developed by Edoardo Amitrano (GitHub: EarlyOwl),
# using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)
# ver 1.0.0 -- This script is licensed under the MIT License

# Import VMware PowerCLI module
Import-Module VMware.PowerCLI

# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere

# Get all datastores in the vCenter Datacenters
$datastores = Get-Datastore -Location (Get-Datacenter)

# Create an empty array to hold the datastore information
$datastoreInfo = @()

# Loop through each datastore
foreach ($datastore in $datastores) {
    # Get the datastore type, host or network path, available space in GB and %
    $type = $datastore.ExtensionData.Info.GetType().Name
    $path = $datastore.ExtensionData.Info.Url
    $freeSpaceGB = "{0:N2}" -f ($datastore.FreeSpaceGB)
    if ($datastore.CapacityGB -eq 0) {
        $freeSpacePercent = "N/A"
    } else {
        $freeSpacePercent = "{0:N2}" -f ($datastore.FreeSpaceGB / $datastore.CapacityGB * 100)
    }

    # Add the information to the array
    $datastoreInfo += New-Object PSObject -Property @{
        Name = $datastore.Name
        Type = $type
        Path = $path
        FreeSpaceGB = $freeSpaceGB
        FreeSpacePercent = $freeSpacePercent
    }
}

$PreContent = "<style>table, th, td { border: 1px solid black;}</style>"
$PostContent = "<br>"
$datastoreInfo | ConvertTo-Html -Fragment -PreContent $PreContent -PostContent $PostContent | Out-File "datastore_info.html"

# Disconnect from vCenter server
Disconnect-VIServer * -Force -Confirm:$false

<#
  .SYNOPSIS
  Script developed by Edoardo Amitrano (EarlyOwl), using information and code provided by OpenAI's ChatGPT on 13/01/2023 (https://openai.com/)

  .DESCRIPTION
  Datastores-Report.ps1 - ver 1.0.0
  This script retrieves informations about the datastores in the datacenter like name, available space, free space percentage, etc.
  It then outputs everything on a nicely formatted HTML table.

  .INPUTS
  None. You cannot pipe objects to Datastores-Report.ps1.

  .OUTPUTS
  Datastores-Report.ps1 generates an output file named datastore_info.html in the current directory.

  .EXAMPLE
  PS> .\Datastores-Report.ps1

  .NOTES
  Remember to edit the Connect-VIServer parameters to fit your environment.
  This script is licensed under the MIT License.

  .LINK
  GitHub repo: https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo

#>
