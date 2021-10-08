# Hashicorp.Vault.Manager
Powershell module for Hashicorp Vault

Install this module from PSGallery
```
Install-Module -Name Hashicorp.Vault.Manager
```

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

$secret = @{password = 'this is a secret'}
Set-VaultSecret -path secret/data/myfolder/mysecret -secret $secret

$group = @{
  name = "mygroup"
  type = "external"
  policies = @("mypolicy")
  metadata = @{responsibility = "manage my secrets"}
}
Set-VaultGroup $group

$groupAlias = @{
  name = "????????-????-????-????-????????????" # Azure Group ID
  mount_accessor = "auth_oidc_????????" # Accessor ID
  canonical_id = "????????-????-????-????-????????????" # Vault group ID
}
Set-VaultGroupAlias $groupAlias

$policy = @{
  name = "mypolicy"
  policy = @'
path "secret/metadata/" {
  capabilities = ["list", "read"]
}

path "secret/+/myfolder/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
'@  
}
Set-VaultPolicy $policy
```
