# Hashicorp.Vault.Manager
Powershell module for Hashicorp Vault

Function List
==================
```
Get-VaultGroup
Get-VaultGroupAlias
Get-VaultGroupAliasID
Get-VaultPolicy
Get-VaultPolicyName
Get-VaultSecret
Get-VaultServer
Remove-VaultGroup
Remove-VaultGroupAlias
Remove-VaultPolicy
Remove-VaultSecret
Set-VaultGroup
Set-VaultGroupAlias
Set-VaultPolicy
Set-VaultSecret
```

Example
==================
```
Get-VaultServer -Address myserver.mydomain.com -token mytoken
Get-VaultPolicyName | Get-VaultPolicy
Get-VaultGroupAliasID | Get-VaultGroupAlias
```
