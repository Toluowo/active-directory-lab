#---------Variable Definition----------------------#

$NUMBER_OF_ACCOUNTS_TO_CREATE = 100 #Specifeis the number of user to create
$SET_USERS_PASSWORD = "UserPass-1" #Specifies the password to use for each user
$NEW_OU_PATH = New-ADOrganizationalUnit -Name IT_USERS -ProtectedFromAccidentalDeletion $false #Creates a new OU named IT_USERS and ensure the OU can be deleted without extra confirmation
$OU_PATH = "OU=IT_USERS,DC=mydomain,DC=com" #Specifies the distinguished name where the users will be created inside the domain

#---------Function to generate random name----------------------#
Function generate-random-name() {
    $consonants = @('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z')
    $vowels = @('a','e','i','o','u')
    $nameLength = Get-Random -Minimum 4 -Maximum 8
    $name = ""

    for ($i = 0; $i -lt $nameLength; $i++) {
        if ($i % 2 -eq 0) {
            $name += $consonants[(Get-Random -Minimum 0 -Maximum $($consonants.Count))]
        } else {
            $name += $vowels[(Get-Random -Minimum 0 -Maximum $($vowels.Count))]
        }
    }

    return $name.Substring(0,1) + $name.Substring(1)
}

#---------Account creation----------------------#

$count = 1
while ($count -le $NUMBER_OF_ACCOUNTS_TO_CREATE) {
    $firstName = generate-random-name #Calls the generate random name function to generate first name
    $lastName = generate-random-name #Calls the generate random name function to generate last name
    $username = "$firstName.$lastName" #combines first name and last name
    $password = ConvertTo-SecureString $SET_USERS_PASSWORD -AsPlainText -Force #Converts plain password to secure string

    Write-Host "Creating user: $username" -BackgroundColor Black -ForegroundColor Blue

#---------Creating active directory user----------------------#

    try {

        New-AdUser -AccountPassword $password `
                   -GivenName $firstName `
                   -Surname $lastName `
                   -DisplayName "$firstName $lastName" `
                   -Name $username `
                   -SamAccountName $username `
                   -UserPrincipalName "$username@mydomain.com" `
                   -EmployeeID $count `
                   -PasswordNeverExpires $true `
                   -Path $OU_PATH `
                   -Enabled $true

        Write-Host "User $username created successfully!" -ForegroundColor Green #displays success if AD user created successfully in green foreground color

    catch {
        Write-Host "Error creating user $username" -ForegroundColor Red #displays error if AD user creation is not successful in red foreground color
    }

    $count++    
    
}