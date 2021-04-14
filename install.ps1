# Install OpenSSH server to Windows
# Tested on Windows Server 2019
# Created by Yevgeniy Goncharov, https://sys-adm.in

# Install PS 7

# Vars
$config = "$ENV:ALLUSERSPROFILE\ssh\sshd_config"
$offsetPAram = "# override default of no subsystems"
$param = "Subsystem	powershell pwsh.exe -sshs -NoLogo -NoProfile"

# Func
$NewContent = Get-Content -Path $config |
    ForEach-Object {
        # Output the existing line to pipeline in any case
        $_

        # If line matches regex
        if($_ -match ('^' + [regex]::Escape($offsetPAram)))
        {
            # Add output additional line
            $param
        }
 
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Set sshd to automatic mode
Set-Service -Name sshd -StartupType 'Automatic'

# Run sshd
Start-Service sshd

# Add pwsh subsystem param in to sshd_config
$NewContent | Out-File -FilePath $config -Encoding Default -Force

# Restart sshd
Get-Service -Name sshd | Restart-Service

# Additional actions
mkdir $ENV:UserProfile\.ssh
New-Item $ENV:UserProfile\.ssh\authorized_keys -Type file
