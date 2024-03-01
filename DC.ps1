# Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# $domain_password  = $args[0]
# $domain_user  = $args[1]
# $domain  = $args[2]
# $admin_password = $args[3]

$password = $args[0] | ConvertTo-SecureString -AsPlainText -Force
$username = "$args[2]\$args[1]"
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

# Path to output file
$outputFilePath = "C:\Windows\Temp\Script_result.txt"

try {
Install-ADDSDomainController -DomainName $domain  -credential $credential -NoGlobalCatalog:$false -CreateDnsDelegation:$false -SiteName 'Default-First-Site-Name'  -Confirm:$false -InstallDns -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText $args[3] -Force)
# If successful, output custom success message
$output = "Domain Controller installation was successful."
} catch {
    # If an error occurs, output the error message
    $output = "An error occurred during Domain Controller installation: $_"
}

# Save output to a file
$output | Out-File -FilePath $outputFilePath
