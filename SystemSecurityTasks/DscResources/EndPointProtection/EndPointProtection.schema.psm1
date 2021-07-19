<#
    .DESCRIPTION
        Creates DSC resource that monitors Nodes to ensure specific Antivirus agents are running on them.
#>
#Requires -Module EndPointProtectionDSC

configuration EndPointProtection
{
    param (
        [Parameter(Mandatory)]
        [System.Collections.Hashtable[]]
        $Software
    )

    Import-DscResource -ModuleName EndPointProtectionDSC


    foreach ($s in $Software)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $s = @{ } + $s

        # if not specified, ensure 'Present'
        if (-not $s.ContainsKey('Ensure'))
        {
            $s.Ensure = 'Present'
        }

        # create execution name for the DSC resource
        $executionName = "$($s.Name -replace '[-().:\s]','_')"

        # create DSC resource for Endpoint Protection Status
        EPAntivirusStatus "$executionName"
        {
            AntivirusName = $s.Name
            Status        = $s.Status
            Ensure        = $s.Ensure
        }
    }
}