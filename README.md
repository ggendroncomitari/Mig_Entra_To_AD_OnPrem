# 🚀 Entra ID to On-Prem Active Directory Migration

This project provides scripts and automation tools to migrate Windows workstations and users from Microsoft Entra ID (formerly Azure AD) to an on-premises Active Directory domain.

## 📌 Project Goals

- Export user information from Entra ID
- Create matching user accounts in Active Directory
- Disconnect workstations from Entra ID (#TODO)
- Join workstations to the local Active Directory domain (#TODO)
- Automate the process using PowerShell or Python (#TODO)

## 🧰 Prerequisites

### For User Export

- PowerShell 5.1+
- Microsoft Graph PowerShell module (`Microsoft.Graph`)
- Admin access to Entra ID / Microsoft 365

### For Workstation Migration

- Admin (SYSTEM) privileges on the target machine
- Network access to the local domain controller
- A domain account with permissions to join computers to the domain
- PowerShell execution policy must allow script execution
