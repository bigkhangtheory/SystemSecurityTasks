# WSManListener

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Transport** | Key | String | The transport type of WS-Man Listener. | `HTTP`, `HTTPS` |
| **Ensure** | Required | String | Specifies whether the WS-Man Listener should exist. | `Present`, `Absent` |
| **Port** | Write | UInt16 | The port the WS-Man Listener should use. Defaults to 5985 for HTTP and 5986 for HTTPS listeners. | |
| **Address** | Write | String | The Address that the WS-Man Listener will be bound to. The default is * (any address). | |
| **Issuer** | Write | String | The Issuer of the certificate to use for the HTTPS WS-Man Listener if a thumbprint is not specified. | |
| **SubjectFormat** | Write | String | The format used to match the certificate subject to use for an HTTPS WS-Man Listener if a thumbprint is not specified. | `Both`, `FQDNOnly`, `NameOnly` |
| **MatchAlternate** | Write | Boolean | Should the FQDN/Name be used to also match the certificate alternate subject for an HTTPS WS-Man Listener if a thumbprint is not specified. | |
| **DN** | Write | String | This is a Distinguished Name component that will be used to identify the certificate to use for the HTTPS WS-Man Listener if a thumbprint is not specified. | |
| **Hostname** | Write | String | The host name that a HTTPS WS-Man Listener will be bound to. If not specified it will default to the computer name of the node. | |
| **Enabled** | Read | Boolean | Returns true if the existing WS-Man Listener is enabled. | |
| **URLPrefix** | Read | String | The URL Prefix of the existing WS-Man Listener. | |
| **CertificateThumbprint** | Write | String | The Thumbprint of the certificate to use for the HTTPS WS-Man Listener. | |

## Description

This resource is used to create, edit or remove WS-Management HTTP/HTTPS listeners.

## SubjectFormat Parameter Notes

The subject format is used to determine how the certificate for the listener
will be identified. It must be one of the following:

- **Both**: Look for a certificate with a subject matching the computer FQDN.
  If one can't be found the flat computer name will be used. If neither
  can be found then the listener will not be created.
- **FQDN**: Look for a certificate with a subject matching the computer FQDN
  only. If one can't be found then the listener will not be created.
- **ComputerName**: Look for a certificate with a subject matching the computer
  FQDN only. If one can't be found then the listener will not be created.

## Examples

### Example 1

This will create or enable an HTTP WS-Man Listener on port 5985.
configuration Sample_WSManListener_HTTP

```powershell
Configuration WSManListener_HTTP_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManListener HTTP
        {
            Transport = 'HTTP'
            Ensure    = 'Present'
        } # End of WSManListener Resource
    } # End of Node
} # End of Configuration
```

### Example 2

Create an HTTPS Listener using a LocalMachine certificate that
is installed and issued by 'CN=CONTOSO.COM Issuing CA, DC=CONTOSO, DC=COM'
on port 5986.

```powershell
Configuration WSManListener_HTTPS_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManListener HTTPS
        {
            Transport = 'HTTPS'
            Ensure    = 'Present'
            Issuer    = 'CN=CONTOSO.COM Issuing CA, DC=CONTOSO, DC=COM'
        } # End of WSManListener Resource
    } # End of Node
} # End of Configuration
```

### Example 3

Create an HTTPS Listener using a LocalMachine certificate containing a DN matching
'O=Contoso Inc, S=Pennsylvania, C=US' that is installed and issued by
'CN=CONTOSO.COM Issuing CA, DC=CONTOSO, DC=COM' on port 5986.

```powershell
Configuration WSManListener_HTTPS_WithDN_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManListener HTTPS
        {
            Transport = 'HTTPS'
            Ensure    = 'Present'
            Issuer    = 'CN=CONTOSO.COM Issuing CA, DC=CONTOSO, DC=COM'
            DN        = 'O=Contoso Inc, S=Pennsylvania, C=US'
        } # End of WSManListener Resource
    } # End of Node
} # End of Configuration
```

### Example 4

Create an HTTPS Listener using a LocalMachine certificate with a thumbprint
matching 'F2BE91E92AF040EF116E1CDC91D75C22F47D7BD6'. The host name in the
certificate must match the name of the host machine.

```powershell
Configuration WSManListener_HTTPS_WithThumbprint_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManListener HTTPS
        {
            Transport             = 'HTTPS'
            Ensure                = 'Present'
            CertificateThumbprint = 'F2BE91E92AF040EF116E1CDC91D75C22F47D7BD6'
        } # End of WSManListener Resource
    } # End of Node
} # End of Configuration
```

### Example 5

Create an HTTPS Listener using a LocalMachine certificate with a thumbprint
matching 'F2BE91E92AF040EF116E1CDC91D75C22F47D7BD6'. If the subject in the
certificate does not match the name of the host then the Hostname parameter
must be specified. In this example the subject in the certificate is
'WsManListenerCert'.

```powershell
Configuration WSManListener_HTTPS_WithThumbprintAndHostname_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManListener HTTPS
        {
            Transport             = 'HTTPS'
            Ensure                = 'Present'
            CertificateThumbprint = 'F2BE91E92AF040EF116E1CDC91D75C22F47D7BD6'
            Hostname              = 'WsManListenerCert'
        } # End of WSManListener Resource
    } # End of Node
} # End of Configuration
```

