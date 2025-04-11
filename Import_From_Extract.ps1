Import-Module ActiveDirectory

$csvPath = ".\entra_users.csv"

$ou = "OU=Migration,DC=mycompagny,DC=lan"

$default_pasword = "myDefaultPassword!"

Import-Csv -Path $csvPath | ForEach-Object {
    $sam = $_.UserPrincipalName.Split("@")[0]

    New-ADUser -Name $_.DisplayName `
               -SamAccountName $sam `
               -UserPrincipalName $_.UserPrincipalName `
               -EmailAddress $_.Mail `
               -GivenName $_.GivenName `
               -Surname ($_.DisplayName -replace "^.*\s", "") `
               -Title $_.JobTitle `
               -Department $_.Department `
               -Company $_.CompanyName `
               -City $_.City `
               -State $_.State `
               -StreetAddress $_.StreetAddress `
               -Country $_.Country `
               -MobilePhone $_.MobilePhone `
               -AccountPassword (ConvertTo-SecureString $default_pasword -AsPlainText -Force) `
               -Path $ou `
               -Enabled $true `
               -ChangePasswordAtLogon $true

    Write-Host "✅ Utilisateur created :" $_.DisplayName
}
