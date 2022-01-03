# AuditPolicies



<br />

## Project Information

|                  |                                                                                                                  |
| ---------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/SystemSecurityTasks/tree/master/SystemSecurityTasks/DscResources/AuditPolicies |
| **Dependencies** | [SecurityPolicyDsc][SecurityPolicyDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]             |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `AuditPolicies`

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |

---

#### Table. Attributes of ``

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |

---

<br />

## Example `AuditPolicies`

```yaml
AuditPolicies:
  # see https://github.com/dsccommunity/AuditPolicyDsc
  Options:
    - Name:  AuditBaseObjects
      Value: Enabled
    - Name:  AuditBaseDirectories
      Value: Enabled

  Subcategories:
    - Name:      Logon
      AuditFlag: Success
      Ensure:    Absent
    - Name:      Logon
      AuditFlag: Failure
      Ensure:    Present
    - Name: Credential Validation
      AuditFlag: Success
      Ensure: Present
    - Name: Credential Validation
      AuditFlag: Failure
      Ensure: Present
    - Name: 'Application Group Management'
      AuditFlag: Success
      Ensure: Present
    - Name: 'Application Group Management:'
      AuditFlag: Failure
      Ensure: Present

  Guids:
    - Name:      Logon
      AuditFlag: Success
      Ensure:    Absent
    - Name:      Logon
      AuditFlag: Failure
      Ensure:    Present

  CsvPath: C:\Temp\AuditPolBackup.csv  # Path to the CSV file to apply to the node

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  AuditPolicies:
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
