# SecurityBase



<br />

## Project Information

|                  |                                                                                                                 |
| ---------------- | --------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/SystemSecurityTasks/tree/master/SystemSecurityTasks/DscResources/SecurityBase |
| **Dependencies** | [SecurityPolicyDsc][SecurityPolicyDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]            |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                                              |

<br />

## Parameters

<br />

### Table. Attributes of `SecurityBase`

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |

---

#### Table. Attributes of ``

| Parameter | Attribute | DataType | Description | Allowed Values |
| :-------- | :-------- | :------- | :---------- | :------------- |

---

<br />

## Example `SecurityBase`

```yaml
SecurityBase:
Role: BaseLine

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  SecurityBase:
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
