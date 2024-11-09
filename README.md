# Win11Update
A simple and powerful Windows PowerShell script that checks for updates and updates the system, according to the available updates.

## How to use
To use this script, follow this steps:

1. Download the source code;
2. Extract it to some locate in your Windows system (recommended: 'C:\');
3. Run your PowerShell as an admin;
4. Copy and paste the following command on the PowerShell CLI:
   > `powershell.exe -ExecutionPolicy ByPass -File '<locate>\AttWindows.ps1'`

 ## Explanation
<p>
 This script requires the admin permission because the change of execution policy and the instalation of some packages (NuGet - a Windows official tool and PSWindowsUpdate - open source lib) and updates.
   You can see more about these libraries here:
   - NuGet:
      * https://learn.microsoft.com/pt-br/nuget/what-is-nuget
   - PSWindowsUpdate:
      * https://www.powershellgallery.com/packages/PSWindowsUpdate/2.2.1.5
<p>

   to write...

