Connect-Graph -scopes "User.Read.All", "Group.Read.All"

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

$export | Export-Csv -Path ".\entra_users.csv" -NoTypeInformation -Encoding UTF8
$allGroups = Get-MgGroup -All
$results = @()
foreach ($group in $allGroups) {
    $groupId = $group.Id
    $groupName = $group.DisplayName

    $members = Get-MgGroupMember -GroupId $groupId -All

    foreach ($member in $members) {
        if ($member.AdditionalProperties.'@odata.type' -eq '#microsoft.graph.user') {
            $user = Get-MgUser -UserId $member.Id
            $results += [PSCustomObject]@{
                Groupe        = $groupName
                NomUtilisateur = $user.DisplayName
                Email         = $user.UserPrincipalName
                IDUtilisateur = $user.Id
            }
        }
    }
}

$results | Export-Csv -Path "groups_and_members.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Export here : groups_and_members.csv"

