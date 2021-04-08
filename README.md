## Install OpenSSH server in to Windows Server

### Additional short commands

Check availability OpenSSH
```
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
```

Check exist ssh firewall rules
```
Get-NetFirewallRule -Name *ssh*
```

Create new firewall rule for ssh
```
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

Restart sshd
```
Get-Service -Name sshd | Restart-Service
```

Uninstall sshd
```
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 
```

### References
* https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
* https://superuser.com/questions/821112/add-line-to-text-file-after-specific-line-with-powershell
* https://forum.sys-adm.in/t/windows-ssh-new-pssession-subsystem-request-failed-on-channel-0/7600