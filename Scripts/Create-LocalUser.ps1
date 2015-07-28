function Create-LocalUser
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $userName,
        [Parameter(Mandatory=$true)]
        [string] $passWord,
        [Parameter(Mandatory=$true)]
        [string] $localGroup
    )
    process{

        $objOu = [ADSI]"WinNT://${env:Computername}"
        $localUsers = $objOu.Children | where {$_.SchemaClassName -eq 'user'}  | % {$_.name[0].ToString()}

        if($localUsers -NotContains $userName)
        {
            $user = $objOU.Create("User", $userName)
            $user.SetPassword($passWord)
            $user.SetInfo()

            $adminGroup = [ADSI]"WinNT://${env:Computername}/${localGroup},group" 
            $adminGroup.Add($user.Path)

            return $true
        }
        else
        {      
            return $false
        }
    }
}