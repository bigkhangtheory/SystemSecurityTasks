# WSManConfig

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes' | `Yes` |
| **MaxEnvelopeSizekb** | Write | UInt32 | Specifies the WS-Man maximum envelope size in KB. The minimum value is 32 and the maximum is 4294967295. | |
| **MaxTimeoutms** | Write | UInt32 | Specifies the WS-Man maximum timeout in milliseconds. The minimum value is 500 and the maximum is 4294967295. | |
| **MaxBatchItems** | Write | UInt32 | Specifies the WS-Man maximum batch items. The minimum value is 1 and the maximum is 4294967295. | |

## Description

This resource is used to configure general WS-Man settings.

## Examples

### Example 1

Set the WS-Man maximum envelope size to 2000KB, the
maximum timeout to 120 seconds and the maximum batch
items to 64000.

```powershell
Configuration WSManConfig_Config
{
    Import-DscResource -Module WSManDsc

    Node localhost
    {
        WSManConfig Config
        {
            IsSingleInstance  = 'Yes'
            MaxEnvelopeSizekb = 2000
            MaxTimeoutms      = 120000
            MaxBatchItems     = 64000
        } # End of WSManConfig Resource
    } # End of Node
} # End of Configuration
```

