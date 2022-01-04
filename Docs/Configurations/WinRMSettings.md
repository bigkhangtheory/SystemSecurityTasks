# WinRMSettings



<br />

## Project Information

|                  |                                                                                                                  |
| ---------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/SystemSecurityTasks/tree/master/SystemSecurityTasks/DscResources/WinRMSettings |
| **Dependencies** | [SecurityPolicyDsc][SecurityPolicyDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]             |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `WinRMSettings`

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |
| **MaxEnvelopeSizekb** | Write | UInt32 | Specifies the WS-Man maximum envelope size in KB. The minimum value is 32 and the maximum is 4294967295. | |
| **MaxTimeoutms** | Write | UInt32 | Specifies the WS-Man maximum timeout in milliseconds. The minimum value is 500 and the maximum is 4294967295. | |
| **MaxBatchItems** | Write | UInt32 | Specifies the WS-Man maximum batch items. The minimum value is 1 and the maximum is 4294967295. | |
| **Listener** | | `[Hashtable]` | | |
| **Service** | | `[Hashtable]` | |

---

#### Table. Attributes of `WinRMSettings::Listener`

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |
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

---

#### Table. Attributes of `WinRMSettings::Service`

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |
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

---

<br />

## Example `WinRMSettings`

```yaml
WinRMSettings:
  MaxEnvelopeSizekb: 8192
  MaxTimeoutms: 60000
  MaxBatchItems: 32000

  Listener:
    Transport: HTTPS
    #Address: "*"
    Issuer: SUBCA-01
    SubjectFormat: NameOnly
    DN: DC=example,DC=com
    MatchAlternate: true

  Service:
    MaxConnections: 600
    MaxConcurrentOperationsPerUser: 1500
    EnumerationTimeoutMS: 480000
    MaxPacketRetrievalTimeSeconds: 120
    AuthBasic: true
    AuthKerberos: true
    AuthNegotiate: true
    AuthCertificate: false
    AuthCredSSP: false
    AuthCbtHardeningLevel: Strict

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  WinRMSettings:
    merge_hash: deep

```

<br />


[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1

[AuditPolicyDsc]: https://github.com/dsccommunity/AuditPolicyDsc
[AuditPolicySubcategory]: https://github.com/dsccommunity/AuditPolicyDsc
[AuditPolicyCsv]: https://github.com/dsccommunity/AuditPolicyDsc
[AuditPolicyGUID]: https://github.com/dsccommunity/AuditPolicyDsc

[SecurityPolicyDsc]: https://github.com/dsccommunity/SecurityPolicyDsc
[AccountPolicy]: https://github.com/dsccommunity/SecurityPolicyDsc
[UserRightsAssignment]: https://github.com/dsccommunity/SecurityPolicyDsc

[WSManDsc]: https://github.com/dsccommunity/WSManDsc
[WSManConfig]: https://github.com/dsccommunity/WSManDsc/wiki/WSManConfig
[WSManListener]: https://github.com/dsccommunity/WSManDsc/wiki/WSManListener
[WSManServiceConfig]: https://github.com/dsccommunity/WSManDsc/wiki/WSManServiceConfig
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
