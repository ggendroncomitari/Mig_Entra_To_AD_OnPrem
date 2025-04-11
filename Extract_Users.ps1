Connect-MgGraph -Scopes "User.Read.All"

$users = Get-MgUser -All | Where-Object { $_.AccountEnabled -eq $true }

$export = $users | Select-Object `
    DisplayName,
    UserPrincipalName,
    Mail,
    Birthday,
    City,
    CompanyName,
    Country,
    Department,
    GivenName,
    JobTitle,
    MobilePhone,
    State,
    StreetAddress,
    UserType

# Export vers fichier CSV
$export | Export-Csv -Path ".\entra_users.csv" -NoTypeInformation -Encoding UTF8

Write-Host "✅ Export here : entra_users.csv"
