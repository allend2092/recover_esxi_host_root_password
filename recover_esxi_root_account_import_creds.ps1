# Import the VMware PowerCLI module for vSphere automation
Import-Module VMware.VimAutomation.Core

# Read the configuration file 'config.json' and convert its content to a PowerShell object
$config = Get-Content -Path 'config.json' | ConvertFrom-Json

# Attempt to establish a connection to the vCenter Server
# The -Force parameter is used to bypass SSL certificate validation
try {
    Connect-VIServer -Server $config.vCenterServer -User $config.username -Password $config.password -Force
} catch {
    # If there's an error during connection, print the error and exit the script
    Write-Error "Failed to connect to vCenter Server: $_"
    exit
}

# Extract vCenter connection details from the configuration object
$vcenter = $config.vCenterServer
$vcenter_username = $config.username
$vcenter_password = $config.password

# Define ESXi host details
$esxiFQDN = '<fqdn>'
$esxiLoginAccount = 'root'
$esxiNewPassword = 'new password'

# Retrieve the VMHost object for the specified ESXi host
$esxHost = Get-VMHost -Name $esxiFQDN

# Get an ESXCLI handle for the specified ESXi host
$esxCliHandle = Get-EsxCli -VMHost $esxHost -V2

# Create argument object for setting the password
$esxCliArgs = $esxCliHandle.system.account.set.CreateArgs()
$esxCliArgs.id = $esxiLoginAccount
$esxCliArgs.password = $esxiNewPassword
$esxCliArgs.passwordconfirmation = $esxiNewPassword

# Invoke the ESXCLI command to set the new password for the specified account
$esxCliHandle.system.account.set.Invoke($esxCliArgs)

# Disconnect from the vCenter Server without confirmation
Disconnect-VIServer -Server $vcenter -Confirm:$false

