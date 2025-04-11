# 🚀 Entra ID to On-Prem Active Directory Migration

This project provides scripts and automation tools to migrate Windows workstations and users from Microsoft Entra ID (formerly Azure AD) to an on-premises Active Directory domain.

## 📌 Project Goals

- Export user information from Entra ID
- Create matching user accounts in Active Directory
- Migrate workstations from Entra ID to on-prem AD using the WAPT package
- Automate the process using PowerShell and WAPT

## 🧰 Prerequisites

### For User Export

- PowerShell 5.1+
- Microsoft Graph PowerShell module (`Microsoft.Graph`)
- Admin access to Entra ID / Microsoft 365

### For Workstation Migration

- WAPT package `comi-leave_Entra_to_OnPrem_0-1_PROD.wapt` (included in this repository)
- Set `comi-leave_Entra_to_OnPrem_0-1_PROD.wapt` as dependances to this computer using WAPT.

## 📤 Export Users from Entra ID

Use `Export-EntraID-Users.ps1` to export all enabled users with useful properties (e.g., name, email, job title, department, etc.) to a CSV file.

```powershell
.\Extract_Users.ps1
```

## 👥 Import Users into Active Directory

Use Import-Users-To-AD.ps1 to create users in your on-prem Active Directory from the exported CSV file.

Update the script with:

Your target OU (Organizational Unit)

The default password for new users

```powershell
.\Import_From_Extract.ps1
```

## 💻 Migrate Workstations from Entra ID to AD

To migrate workstations from Entra ID to your on-prem Active Directory, use the WAPT package included in this repository: comi-leave_Entra_to_OnPrem_0-1_PROD.wapt.

This WAPT package automates the migration process, including:

Unregistering the device from Entra ID

Joining the device to the local domain

Rebooting the machine if needed

Simply deploy and execute the package on each workstation using WAPT.

## ⚠️ Important Notes

Make sure to test all scripts and the WAPT package in a lab environment before deploying to production.

Azure AD unjoin is not officially supported via PowerShell. This script attempts to unregister the device but results may vary depending on your environment and policies.

Use secure methods to store and retrieve credentials (avoid hardcoding passwords in production environments).

## TO DO

Add Groups extract and import to Active Directory
Add python compatibility for Samba Active Directory Support
