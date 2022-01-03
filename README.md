# SystemSecurityTasks

This repo provides a structured project for building re-usable and composable **DSC configurations** used for managing and configuring system security policies and settings.

Desired State Configuration (DSC) is a declarative management platform in PowerShell to configure, deploy, and manage systems.

If you are new to DSC, configurations, or resources, you can learn more about them [here](https://docs.microsoft.com/en-us/powershell/scripting/dsc/overview/overview).

## Project Overview

This project aims to simplify and allow direct re-use of shared **DSC configurations** in new environments by:

- Providing a scaffolding project structure similar to PowerShell modules.
- Creating a self-contained model by declaring and pulling project dependencies from a repository.
- Pre-defining sane default Configuration Data within the DSC Configuration functions.

### DSC Configurations

The following **DSC configurations** are made available by this project.

| Configurations | Description |
| :------------- | :---------- |

---

## Project Dependencies

This project does not use Desired State Configuration (DSC) as an isolated technology. DSC is just one part in a pipeline that leverages several Microsoft products, PowerShell modules, and open-source projects.

### Project Resources

The **DSC sesources** used in this project include:

| Resource                         | Description                                                                                                                            |
| :------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------- |
| [AuditPolicyDsc][]               | The AuditPolicyDsc module allows you to configure and manage the advanced audit policy on all currently supported versions of Windows. |
| [ComputerManagementDsc][]        | DSC resources for configuration of a Windows computer.                                                                                 |
| [SChannelDsc][]                  | This DSC module is used to manage Secure Channel (SChannel) configurations.                                                            |
| [SecurityPolicyDsc][]            |                                                                                                                                        |
| [WindowsDefenderDsc][]              |                                                                                                                                        |
| [WSManDsc][]                     |                                                                                                                                        |
| [xPSDesiredStateConfiguration][] |                                                                                                                                        |

> For information about the building blocks that perform work described by Configurations, see the GitHub repo for [DSC Resources][DSC Resources].

---

### Project PowerShell modules

The **PowerShell modules** used in the build pipeline of this project include:

| Module                                     | Description                                                                                                                        |
| :----------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| [BuildHelpers][BuildHelpers]               | Helper functions for PowerShell CI/CD scenarios                                                                                    |
| [Datum][Datum]                             | Module to manage Hierachical Configuration Data                                                                                    |
| [Datum.InvokeCommand][Datum.InvokeCommand] | Datum Handler module to encrypt and decrypt secrets in Datum using Dave Wyatt's ProtectedData module                               |
| [Datum.ProtectedData][Datum.ProtectedData] | Datum Handler module to encrypt and decrypt secrets in Datum using Dave Wyatt's ProtectedData module                               |
| [DscBuildHelpers][DscBuildHelpers]         | Build Helpers for DSC Resources and Configurations                                                                                 |
| [InvokeBuild][InvokeBuild]                 | Build and test automation in PowerShell                                                                                            |
| [Pester][Pester]                           | Pester provides a framework for running BDD style Tests to execute and validate PowerShell commands inside of PowerShell.          |
| [powershell-yaml][powershell-yaml]         | Powershell module for serializing and deserializing YAML.                                                                          |
| [ProtectedData][ProtectedData]             | Encrypt and share secret data between different users and computers.                                                               |
| [PSScriptAnalyzer][PSScriptAnalyzer]       | Provides script analysis and checks for potential code defects in the scripts by applying a group of built-in or customized rules. |
| [PSDeploy][PSDeploy]                       | Module to simplify PowerShell based deployments                                                                                    |

---

## Project Acknowledgements

This project is inspired by [Gael Colas'](https://gaelcolas.com) and his opinions on how an **infrastructure represented as code** with DSC could look like. Modeling **Puppet's R10K and Hiera**, this structure allows for separating staging environments via `git` branches so that successful changes can be promoted through each environment, while keeping the infrastructure consistent (more on this later).

The overall concept follows [The Release Pipeline Model](https://aka.ms/trpm), a whitepaper written by [Michael Greene](https://twitter.com/migreene) and [Steven Murawski](https://twitter.com/StevenMurawski) that is a must-read and describing itself like this:

> There are benefits to be gained when patterns and practices from developer techniques are applied to operations. Notably, a fully automated solution where infrastructure is managed as code and all changes are automatically validated before reaching production. This is a process shift that is recognized among industry innovators. For organizations already leveraging these processes, it should be clear how to leverage Microsoft platforms. For organizations that are new to the topic, it should be clear how to bring this process to your environment and what it means to your organizational culture. This document explains the components of a Release Pipeline for configuration as code, the value to operations, and solutions that are used when designing a new Release Pipeline architecture.

## Project Guidelines

The [DSC Resource repository](http://github.com/powershell/dscresources) includes guidance on authoring that is applicable to **DSC configurations** as well.

- [Repository Structure](./RepositoryStructure.md)
- [Style Guidelines](./StyleGuidelines.md)
- [Technical Summary](./TechnicalSummary.md)

[DSC Resources]: https://docs.microsoft.com/en-us/powershell/dsc/resources/resources?view=dsc-1.1
[AuditPolicyDsc]: https://github.com/dsccommunity/AuditPolicyDsc
[ComputerManagementDsc]: https://github.com/dsccommunity/ComputerManagementDsc
[SChannelDsc]: https://github.com/dsccommunity/SChannelDsc
[SecurityPolicyDsc]: https://github.com/dsccommunity/SecurityPolicyDsc
[WindowsDefenderDsc]: https://github.com/erjenkin/WindowsDefenderDsc
[WSManDsc]: https://github.com/dsccommunity/WSManDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

[BuildHelpers]: https://github.com/RamblingCookieMonster/BuildHelpers
[Datum]: https://github.com/gaelcolas/Datum
[Datum.InvokeCommand]: https://github.com/raandree/Datum.InvokeCommand
[Datum.ProtectedData]: https://github.com/gaelcolas/Datum.ProtectedData
[DscBuildHelpers]: https://github.com/gaelcolas/DscBuildHelpers
[InvokeBuild]: https://github.com/nightroman/Invoke-Build
[Pester]: https://github.com/pester/Pester
[powershell-yaml]: https://github.com/cloudbase/powershell-yaml
[ProtectedData]: https://github.com/dlwyatt/ProtectedData/
[PSScriptAnalyzer]: https://github.com/PowerShell/PSScriptAnalyzer
[PSDeploy]: https://github.com/RamblingCookieMonster/PSDeploy