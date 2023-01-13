# PowerCLI-SysAdmin-Repo
A repository of useful PowerCLI scripts for your daily SysAdmin duties

***Note! This repo is currrently W.I.P. - code will be added time to time***

## Contents
- [What is this?](#what-is-this)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Script list](#script-list)
- [Misc](#misc)

## What is this?
This is a repository containing useful scripts to perform various tasks on your VMware infrastructure.

## Prerequisites
The scripts in this repo were tested on an environment running:

***Client-Side***
- PowerShell version 5.1
- PowerCLI 13.0

***Server-Side***
- VMware vCenter Server 7.0.3

You can check your PowerShell version by running  ```$PSVersionTable```.

If you don't have the PowerCLI modules installed, you can do so by running ```Install-Module -Name VMware.PowerCLI``` on an elevated PowerShell ([documentation](https://www.powershellgallery.com/packages/VMware.PowerCLI/13.0.0.20829139)).

After the installation, i suggest to:
1. Suppress the CEIP message by running ```Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCeip $false```

2. If you are dealing with self-signed certificates, add an exception to ignore them by default with ```Set-PowerCLIConfiguration -Scope AllUsers -InvalidCertificateAction Ignore```

## Installation
There are several ways to retrieve the scripts. For example, you can either:

- Download the whole branch as a .ZIP archive by clicking ***Code > Download ZIP*** (or [here](https://github.com/EarlyOwl/PowerCLI-SysAdmin-Repo/archive/refs/heads/main.zip))

- Download a single script directly from the PowerShell. For example, to download the script ***Powerstate-Report.ps1*** you can use the following snippet: 
```shell
Invoke-WebRequest -URI https://raw.githubusercontent.com/EarlyOwl/PowerCLI-SysAdmin-Repo/main/scripts/Powerstate-Report.ps1 -Outfile Powerstate-Report.ps1 
```

**REMEMBER:** you should adjust the connection parameters in the scripts to fit your environment!

 ```shell
# Connect to vCenter server
Connect-VIServer -Server vcenter.domain.com -User yourusernamehere -Password yourpasswordhere
 ```

## Usage
Each script comes with its own embedded documentation. For example, to check the docs for the script ***Powerstate-Report.ps1*** you can do so by running:

```shell
 Get-Help .\Powerstate-Report.ps1 -full
```

Anyways, a brief description of every script can be found in the next chapter.

## Script list

#### Quick navigation
- [Powerstate-Report.ps1](#powerstate-reportps1)
- [Datastores-Report.ps1](#datastores-reportps1)
- [Get-Portgroups.ps1](#get-portgroupsps1)
- [Massive-Shutdown.ps1](#massive-shutdownps1)


#### Powerstate-Report.ps1
This script retrieves the power state, uptime and last boot time of all the VMs. It then outputs everything on a nicely formatted HTML table.

<details>
  <summary>Sample output</summary>

![Powerstate-Report.ps1](https://user-images.githubusercontent.com/49495410/212378331-50edcb30-9457-47d7-9541-cba832a2249d.png)

  </details>

#### Datastores-Report.ps1
This script retrieves informations about the datastores in the datacenter, like name, available space, free space percentage, etc. It then outputs everything on a nicely formatted HTML table.

<details>
  <summary>Sample output</summary>

![Datastores-Report.ps1](https://user-images.githubusercontent.com/49495410/212378482-30a73ad7-8168-4d98-9052-c4232683ffe3.png)

  </details>

#### Get-Portgroups.ps1
This script retrieves the list of the portgroups for each vDS. It then outputs everything on a nicely formatted HTML table.

<details>
  <summary>Sample output</summary>

![Get-Portgroups.ps1](https://user-images.githubusercontent.com/49495410/212418986-14846a33-b0f1-4618-a110-19f7075aac1f.png)

 </details>

#### Massive-Shutdown.ps1
This script shuts down every VM it finds in the vCenter, except the vCenter itself (the hostname of the vCenter MUST be specified inside the script).
As this script doesn't produce any output file, there isn't a *sample output* tab below.

## Misc

##### Can I contribute? Can I reuse all/part of this script for other purposes?
Yes and yes.

##### This sucks / You could have done X instead of X!
I'm eager to learn, open an issue or a  pull request to suggest an improvement / fix.
