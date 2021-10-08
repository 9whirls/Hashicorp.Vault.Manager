function Get-VaultServer {
  param(
    [Parameter(Mandatory = $true)]
    [string] 
      $address,
    
    [Parameter(Mandatory = $true)]  
    [string]
      $token,
      
    [ValidateSet(
      "http",
      "https"
    )]
    [string]
      $protocol = 'https'
  )
  
  $prop = @{
    url = "{0}://{1}/v1/" -f $protocol, $address
    head = @{'X-Vault-Token' = $token}
  }
  
  $vault = new-object PSObject -property $prop
  
  $Global:defaultVault = $vault
  return $vault
}

function Get-VaultSecret {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $path,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + $path
    Invoke-RestMethod -Uri $uri -Headers $vault.head
  }
  end {}
}

function Set-VaultSecret {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $path,
      
    [hashtable]
      $secret = @{password = 'this is a secret'},
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + $path
    $data = @{data = $secret} | ConvertTo-Json
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Method Post -Body $data |
      select -expandproperty data
  }
  end {}
}

function Remove-VaultSecret {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $path,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + $path
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Method Delete
  }
  end {}
}

function Get-VaultGroup {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $name,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group/name/$name"
    Invoke-RestMethod -Uri $uri -Headers $vault.head  |
      select -expandproperty data
  }
  end {}
}

function Set-VaultGroup {
  param(
    [parameter(ValueFromPipeline=$true)]
    [hashtable]
      $group,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group"
    $data = $group | ConvertTo-Json
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Body $data -Method Post
  }
  end {}
}

function Remove-VaultGroup {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $name,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group/name/$name"
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Method Delete
  }
  end {}
}

function Get-VaultGroupAliasID {
  param(  
    $vault = $defaultVault
  )
    
  $uri = $vault.url + "identity/group-alias/id?list=true"
  Invoke-RestMethod -Uri $uri -Headers $vault.head | Select -expandproperty data |
    select -expandproperty keys
}

function Get-VaultGroupAlias {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $id,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group-alias/id/$id"
    Invoke-RestMethod -Uri $uri -Headers $vault.head | Select -expandproperty data
  }
  end {}
}

function Set-VaultGroupAlias {
  param(
    [parameter(ValueFromPipeline=$true)]
    [hashtable]
      $alias,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group-alias"
    $data = $alias | ConvertTo-Json
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Body $data -Method Post
  }
  end {}
}

function Remove-VaultGroupAlias {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $id,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "identity/group-alias/id/$id"
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Method Delete
  }
  end {}
}

function Get-VaultPolicyName {
  param( 
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "sys/policy"
    Invoke-RestMethod -Uri $uri -Headers $vault.head | Select -expandproperty data |
      select -expandproperty policies
  }
  end {}
}

function Get-VaultPolicy {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $name,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "sys/policy/$name"
    Invoke-RestMethod -Uri $uri -Headers $vault.head | Select -expandproperty data
  }
  end {}
}

function Set-VaultPolicy {
  param(
    [parameter(ValueFromPipeline=$true)]
    [hashtable]
      $policy,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "sys/policy/$($policy.name)"
    $data = $policy | ConvertTo-Json
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Body $data -Method Post
  }
  end {}
}

function Remove-VaultPolicy {
  param(
    [parameter(ValueFromPipeline=$true)]
    [string]
      $name,
      
    $vault = $defaultVault
  )
  begin {}
  process {
    $uri = $vault.url + "sys/policy/$name"
    Invoke-RestMethod -Uri $uri -Headers $vault.head -Method Delete
  }
  end {}
}
