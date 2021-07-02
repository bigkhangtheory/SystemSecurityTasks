configuration IEEnhancedSecurity
{
    param (
        [Parameter(Mandatory)]
        [hashtable[]]
        $Roles
    )

    Import-DscResource -ModuleName ComputerManagementDsc

    foreach ($role in $Roles)
    {
        # remove case sensitivity of ordered dictionary or hashtable
        $role = @{ } + $role 
        if (($role.Role -ne 'Administrators') -and ($role.Role -ne 'Users'))
        {
            throw "ERROR: The role $($role.Role) is not valid. Must be set to either 'Administrators' or 'Users'."
        }

        if ($null -eq $role.Enabled)
        {
            $role.Enabled = $true
        }

        $executionName = 'iesecurity_{0}' -f "$($role.Role)"
        $role.SuppressRestart = $true 

        $Splatting = @{
            ResourceName = 'IEEnhancedSecurityConfiguration'
            ExecutionName = $executionName
            Properties = $role
            NoInvoke = $true 
        }
        (Get-DscSplattedResource @Splatting).Invoke($role)
    }
}