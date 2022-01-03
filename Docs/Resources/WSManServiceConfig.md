# WSManServiceConfig

## Parameters

| Parameter                            | Attribute | DataType | Description                                                                                               | Allowed Values              |
| ------------------------------------ | --------- | -------- | --------------------------------------------------------------------------------------------------------- | --------------------------- |
| **IsSingleInstance**                 | Key       | String   | Specifies the resource is a single instance, the value must be 'Yes'                                      | `Yes`                       |
| **RootSDDL**                         | Write     | String   | Specifies the security descriptor that controls remote access to the listener.                            |                             |
| **MaxConnections**                   | Write     | UInt32   | Specifies the maximum number of active requests that the service can process simultaneously.              |                             |
| **MaxConcurrentOperationsPerUser**   | Write     | UInt32   | Specifies the maximum number of concurrent operations that any user can remotely open on the same system. |                             |
| **EnumerationTimeoutMS**             | Write     | UInt32   | Specifies the idle time-out in milliseconds between Pull messages.                                        |                             |
| **MaxPacketRetrievalTimeSeconds**    | Write     | UInt32   | Specifies the maximum length of time, in seconds, the WinRM service takes to retrieve a packet.           |                             |
| **AllowUnencrypted**                 | Write     | Boolean  | Allows the client computer to request unencrypted traffic.                                                |                             |
| **AuthBasic**                        | Write     | Boolean  | Allows the WinRM service to use Basic authentication.                                                     |                             |
| **AuthKerberos**                     | Write     | Boolean  | Allows the WinRM service to use Kerberos authentication.                                                  |                             |
| **AuthNegotiate**                    | Write     | Boolean  | Allows the WinRM service to use Negotiate authentication.                                                 |                             |
| **AuthCertificate**                  | Write     | Boolean  | Allows the WinRM service to use client certificate-based authentication.                                  |                             |
| **AuthCredSSP**                      | Write     | Boolean  | Allows the WinRM service to use Credential Security Support Provider (CredSSP) authentication.            |                             |
| **AuthCbtHardeningLevel**            | Write     | String   | Allows the client computer to request unencrypted traffic.                                                | `Strict`, `Relaxed`, `None` |
| **EnableCompatibilityHttpListener**  | Write     | Boolean  | Specifies whether the compatibility HTTP listener is enabled.                                             |                             |
| **EnableCompatibilityHttpsListener** | Write     | Boolean  | Specifies whether the compatibility HTTPS listener is enabled.                                            |                             |

## Description

This resource is used to configure the WS-Man Service.

## Examples

### Example 1

Enable compatibility HTTP and HTTPS listeners, set
maximum connections to 100, allow CredSSP (not recommended)
and allow unecrypted WS-Man Sessions (not recommended).

```powershell
Configuration WSManServiceConfig_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManServiceConfig ServiceConfig
        {
            IsSingleInstance                 = 'Yes'
            MaxConnections                   = 100
            AllowUnencrypted                 = $False
            AuthCredSSP                      = $True
            EnableCompatibilityHttpListener  = $True
            EnableCompatibilityHttpsListener = $True
        } # End of WSManServiceConfig Resource
    } # End of Node
} # End of Configuration
```

