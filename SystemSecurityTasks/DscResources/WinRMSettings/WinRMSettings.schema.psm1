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
        $MaxBatchItems = 32000,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Listener,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable]
        $Service
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


    <#
        .PARAMETER Listener

        This parameter is used to create, edit or remove WS-Management HTTP/HTTPS listeners using the 'WSManListener' DSC resource
    #>

    if ( $null -ne $Listener )
    {
        # remove case sensitivity of ordered dictionary or hasthable
        $l = @{ } + $Listener


        # if 'Transport' not specified, set default to 'HTTP'
        if ( -not $l.ContainsKey( 'Transport' ) )
        {
            $l.Transport = 'HTTP'
        }


        # set the 'Port' property based on 'Transport'
        $l.Port = switch ( $l.Transport )
        {
            'HTTP' { 5985 }
            'HTTPS' { 5986 }
        }

        # if a 'HTTPS' listener is to be configured, then either:
        #   - a matching Certificate property must be specified
        #   - or... a certificate thumbprint must be specified
        if ( $l.Transport -eq 'HTTPS' )
        {
            # check if 'CertificateThumbprint' is not found
            if ( -not $l.ContainsKey( 'CertificateThumbprint' ) )
            {
                # at this point, the certificate thumbprint is not found

                # thereby, a matching property lookup must be specified
                if ( -not ( $l.ContainsKey('Issuer') -or
                        $l.ContainsKey('SubjectFormat') -or
                        $l.ContainsKey('MatchAlternate') -or
                        $l.ContainsKey('DN')
                    ) )
                {
                    throw "ERROR: The property 'CertificateThumbprint' is not found. Specify either 'Issuer', 'SubjectFormet', 'MatchAlternate', or 'DN'."
                }

                # if 'SubjectFormat' is found, verify allowed values
                if ( -not $l.ContainsKey( 'SubjectFormat' ) )
                {
                    # at this point, property 'SubjectFormat' is found

                    if ( ( $l.SubjectFormat -notcontains 'Both', 'FQDNOnly', 'NameOnly' ) )
                    {
                        throw 'ERROR: The property SubjectFormat is found, but not valid.'
                    }

                }
            }
        }

        # if 'Ensure' not specified, default to 'Present'
        if ( -not $l.ContainsKey('Ensure') )
        {
            $l.Ensure = 'Present'
        }


        # create execution name for the resource
        $executionName = "$("$($node.Name)_$($l.Transport)_$($l.Ensure)" -replace '[-().:\s]', '_')"

        $output = @"

        Creating DSC resource for WSManListener with properties:

        WSManListener $executionName
        {
            Transport       = $($l.Transport)
            Port            = $($l.Port)
            Issuer          = $($l.Issuer)
            SubjectFormat   = $($l.SubjectFormat)
            MatchAlternate  = $($l.MatchAlternate)
        }
"@

        Write-Host $output -ForegroundColor Yellow

        # create the DSC resource for 'WSManListener'
        $Splatting = @{
            ResourceName  = 'WSManListener'
            ExecutionName = $executionName
            Properties    = $l
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($l)
    }


    <#
        .PARAMETER Service

    #>
    if ( $PSBoundParameters.ContainsKey( 'Service' ) )
    {
        # remove case sensitivity
        $s = @{ } + $Service


        # set required property 'IsSingleInstance'
        $s.IsSingleInstance = 'Yes'


        # if 'AllowUnencrypted' not specified, set default
        if ( -not $s.ContainsKey( 'AllowUnencrypted' ) )
        {
            $s.AllowUnencrypted = $false
        }


        # create execution name for the resource
        $executionName = "$("$($node.Name)_$($s.MaxConnections)" -replace '[-().:\s]', '_')"


        $output = @"

        Creating DSC resource for WSManServiceConfig with properties:

        WSManServiceConfig $executionName
        {
            IsSingleInstance                 = $($s.IsSingleInstance)
            MaxConnections                   = $($s.MaxConnections)
            AllowUnencrypted                 = $($s.AllowUnencrypted)
        }
"@


        Write-Host $output -ForegroundColor Yellow


        # create the resource
        $Splatting = @{
            ResourceName  = 'WSManServiceConfig'
            ExecutionName = $executionName
            Properties    = $s
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($s)
    }
} #end configuration