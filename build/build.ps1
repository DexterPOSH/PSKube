param(
    $Task = 'Build' # build is the default task, add support to deploy later
)

# dependencies
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
if(-not (Get-Module -ListAvailable PSDepend))
{
    & "$PSScriptRoot/helpers/install-psdepend.ps1"
}
Import-Module PSDepend
$null = Invoke-PSDepend -Path "$PSScriptRoot/requirements.psd1" -Install -Import -Force

Set-BuildEnvironment -Force

Invoke-Build -File $PSScriptRoot/InvokeBuild.ps1 -Task $Task