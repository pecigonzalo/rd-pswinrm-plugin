param (
  [String]$Hostname = $env:RD_NODE_HOSTNAME,
  [String]$Username = $env:RD_CONFIG_USERNAME,
  [String]$Password = "ABC123abc",#$env:RD_CONFIG_PASSWORD,
  [int]$Port = $env:RD_CONFIG_WINRMPORT,
  [String]$Command = $env:RD_EXEC_COMMAND
)

[System.Security.SecureString]$strPass
$strPass = ConvertTo-SecureString -String $Password -AsPlainText -Forc
$Cred = New-Object -TypeName System.Management.Automation.PSCredential `
         -argumentlist $Username, $strPass

$Job = [scriptblock]::Create($Command)

$Session = New-PSSession -ComputerName $Hostname -Credential $Cred -Port $Port
Invoke-Command -Session $Session -Scriptblock $Job