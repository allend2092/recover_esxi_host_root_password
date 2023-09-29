$vcenter = 'vcenter.my-domain.local'
$vcenter_username = '<username>'
$vcenter_password = '<password>'
$esxiFQDN = 'hostname.my-domain.local'
$esxiLoginAccount = 'root'
$esxiNewPassword = 'My New Password!'

Connect-VIServer -Server $vcenter -User $vcenter_username -Password $vcenter_password

$esxHost = Get-VMHost -Name $esxiFQDN
$esxCliHandle = Get-EsxCli -VMHost $esxHost -V2

$esxCliArgs = $esxCliHandle.system.account.set.CreateArgs()
$esxCliArgs.id = $esxiLoginAccount
$esxCliArgs.password = $esxiNewPassword
$esxCliArgs.passwordconfirmation = $esxiNewPassword

$esxCliHandle.system.account.set.Invoke($esxCliArgs)

Disconnect-VIServer -Server $vcenter -Confirm:$false
