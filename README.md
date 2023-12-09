# VMware ESXi Host Password Management Script

## Overview
This PowerShell script is designed to automate the process of updating the root password for an ESXi host. It leverages VMware PowerCLI, a powerful command-line tool used for automating vSphere and ESXi software management.

## Script Functionality
- **Module Import**: The script begins by importing the `VMware.VimAutomation.Core` module, which is essential for vSphere automation.
- **Configuration File**: It reads a configuration file named `config.json`, converting its content into a PowerShell object. This file contains vCenter Server details and credentials.
- **vCenter Connection**: The script attempts to establish a connection to the specified vCenter Server, bypassing SSL certificate validation for simplicity.
- **Error Handling**: If the connection fails, the script prints an error message and exits.
- **ESXi Host Details**: The script defines the Fully Qualified Domain Name (FQDN) of the ESXi host, along with the root account and the new password to be set.
- **VMHost Retrieval**: It retrieves the VMHost object for the specified ESXi host.
- **ESXCLI Handle**: The script obtains an ESXCLI handle for the ESXi host. ESXCLI is a command-line interface tool used to manage ESXi settings.
- **Password Update**: Using the ESXCLI handle, the script creates an argument object to set the new password and then invokes the command to update the password for the root account.
- **vCenter Disconnection**: Finally, the script disconnects from the vCenter Server.

## Usage
1. Update the `config.json` file with your vCenter Server details and credentials.
2. Replace `<fqdn>` with the FQDN of your ESXi host.
3. Set the desired new password in place of `new password`.
4. Run the script in a PowerShell environment with VMware PowerCLI installed.

## Prerequisites
- VMware PowerCLI installed on the system where the script is executed.
- Access to a vCenter Server and an ESXi host.
- Appropriate permissions to update ESXi host settings.

## Security Note
- Ensure that the `config.json` file is stored securely, as it contains sensitive login credentials.
- Consider implementing additional security measures for production environments.

---

*This script is intended for automation purposes in VMware vSphere environments. Use it responsibly and modify it according to your needs.*
