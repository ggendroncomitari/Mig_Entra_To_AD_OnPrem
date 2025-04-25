# Load the AD module
Import-Module ActiveDirectory
$csvPath = "groups_and_members.csv"
$entries = Import-Csv -Path $csvPath
$groups = $entries | Group-Object Groupe

foreach ($group in $groups) {
    $groupName = $group.Name
    $groupSamAccountName = $groupName -replace '[^a-zA-Z0-9]', '_'  # Clean up if necessary

    $adGroup = Get-ADGroup -Filter { Name -eq $groupName } -ErrorAction SilentlyContinue

    if (-not $adGroup) {
        Write-Host "Creating AD group: $groupName"
        New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupScope Global -GroupCategory Security
    } else {
        Write-Host "Group already exists: $groupName"
    }

    foreach ($line in $group.Group) {
        $loginPrefix = $line.Email.Split('@')[0]
        $adUser = Get-ADUser -Filter { SamAccountName -eq $loginPrefix } -ErrorAction SilentlyContinue

        if ($adUser) {
            $isMember = Get-ADGroupMember -Identity $groupName | Where-Object { $_.DistinguishedName -eq $adUser.DistinguishedName }

            if (-not $isMember) {
                Write-Host "Adding $($adUser.SamAccountName) to $groupName"
                Add-ADGroupMember -Identity $groupName -Members $adUser
            } else {
                Write-Host "$($adUser.SamAccountName) is already a member of $groupName"
            }
        } else {
            Write-Warning "User not found in local AD: $loginPrefix"
        }
    }
}
