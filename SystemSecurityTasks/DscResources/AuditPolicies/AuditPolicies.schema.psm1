<#
    .DESCRIPTION
        This DSC configuration contains DSC resources for the management and configuration of the advanced audit policy on all currently supported versions of Windows.
    .LINK
        https://github.com/dsccommunity/AuditPolicyDsc
#>
#Requires -Module AuditPolicyDsc


configuration AuditPolicies
{
    param
    (
        [Parameter(HelpMessage = 'Specifies the audit policy options to configure')]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Options,

        [Parameter(HelpMessage = 'Specifies the subcategories in the advanced audit policy to manage')]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Subcategories,

        [Parameter(HelpMessage = 'Specifies the subcategories in the advanced audit policy to manage')]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Guids,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $CsvPath
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName AuditPolicyDsc

    if ( $null -ne $Options )
    {
        foreach ( $o in $Options )
        {
            # remove case sensitivity of ordered Dictionary or Hashtables
            $o = @{ } + $o

            # create execution name for the resource
            $executionName = 'Option_' + ($o.Name -replace '[-().:\s]', '')

            # create DSC resource
            $Splatting = @{
                ResourceName  = 'AuditPolicyOption'
                ExecutionName = $executionName
                Properties    = $o
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke( $o )
        }
    }
    
    if ( $null -ne $Subcategories )
    {
        foreach ( $s in $Subcategories )
        {
            # remove case sensitivity of ordered Dictionary or Hashtables
            $s = @{ } + $s

            $executionName = 'Subcategory_' + ($s.Name -replace '[-().:\s]', '') + '_' + ($s.AuditFlag -replace '[-().:\s]', '')
            (Get-DscSplattedResource -ResourceName AuditPolicySubcategory -ExecutionName $executionName -Properties $s -NoInvoke).Invoke( $s )
        }
    }

    if ( $null -ne $Guids )
    {
        foreach ( $g in $Guids )
        {
            # remove case sensitivity of ordered Dictionary or Hashtables
            $g = @{ } + $g
            
            $executionName = 'Guid_' + ($g.Name -replace '[-().:\s]', '') + '_' + ($g.AuditFlag -replace '[-().:\s]', '')
            (Get-DscSplattedResource -ResourceName AuditPolicySubcategory -ExecutionName $executionName -Properties $g -NoInvoke).Invoke( $g )
        }
    }

    if ( -not [String]::IsNullOrWhiteSpace($CsvPath) )
    {
        $auditPolicyCsv = @{
            CsvPath          = $CsvPath
            IsSingleInstance = 'Yes'
        }
        (Get-DscSplattedResource -ResourceName AuditPolicyCsv -ExecutionName 'auditPolicyCsv' -Properties $auditPolicyCsv -NoInvoke).Invoke( $auditPolicyCsv )
    }
} #end configuration