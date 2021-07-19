<#
    .DESCRIPTION
        This resource allows configuration of the PowerShell execution policy for different execution scopes.
#>
#Requires -Module ComputerManagementDsc

configuration PSExecutionPolicy
{
    param (
        [Parameter(Mandatory)]
        [System.Collections.Hashtable[]]
        $Policies
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName ComputerManagementDsc

    foreach ($p in $Policies)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $p = @{ } + $p

        # create execution name for the DSC resource
        $executionName = "$($node.Name)_$($p.Scope)_$($p.ExecutionPolicy)"

        # create DSC resource for PowerShell execution policy
        PowerShellExecutionPolicy "$executionName"
        {
            ExecutionPolicyScope = $p.Scope
            ExecutionPolicy      = $p.ExecutionPolicy
        }
    }
}