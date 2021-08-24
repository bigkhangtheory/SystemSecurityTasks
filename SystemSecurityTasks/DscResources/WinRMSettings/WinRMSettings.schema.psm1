<#
    .DESCRIPTION
        This resource is used to configure general WS-Man settings.
    .PARAMETER MaxEnvelopeSizekb
        Specifies the WS-Man maximum envelope size in KB. The minimum value is 32 and the maximum is 4294967295.
    .PARAMETER MaxTimeoutms
        Specifies the WS-Man maximum timeout in milliseconds. The minimum value is 500 and the maximum is 4294967295.
    .PARAMETER MaxBatchItems
        Specifies the WS-Man maximum batch items. The minimum value is 1 and the maximum is 4294967295.
#>
#Requires -Module WSManDsc


configuration WinRMSettings
{
    param
    (
        [Parameter(Mandatory, HelpMessage = 'Specifies the WS-Man maximum envelope size in KB. The minimum value is 32 and the maximum is 4294967295.')]
        [ValidateRange(32, 4294967295)]
        [System.UInt32]
        $MaxEnvelopeSizekb,

        [Parameter(HelpMessage = 'Specifies the WS-Man maximum timeout in milliseconds. The minimum value is 500 and the maximum is 4294967295.')]
        [ValidateRange(500, 4294967295)]
        [System.UInt32]
        $MaxTimeoutms = 60000,

        [Parameter(HelpMessage = 'Specifies the WS-Man maximum batch items. The minimum value is 1 and the maximum is 4294967295.')]
        [ValidateRange(1, 4294967295)]
        [System.UInt32]
        $MaxBatchItems = 32000
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName WSManDsc


    <#
        Create DSC resource for general WS-Man settings
    #>
    WSManConfig "$($MaxEnvelopeSizekb.ToString())_KB"
    {
        IsSingleInstance  = 'Yes'
        MaxEnvelopeSizekb = $MaxEnvelopeSizekb
        MaxTimeoutms      = $MaxTimeoutms
        MaxBatchItems     = $MaxBatchItems
    } #end WSManConfig
} #end configuration