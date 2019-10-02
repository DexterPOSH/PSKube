@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        AddToPath = $True
    }

    # Grab some modules without depending on PowerShellGet
    'InvokeBuild' = @{ DependencyType = 'PSGalleryNuget' }
    'PSDeploy' = @{ DependencyType = 'PSGalleryNuget' }
    'BuildHelpers' = @{ DependencyType = 'PSGalleryNuget' }
    'Pester' = @{ DependencyType = 'PSGalleryNuget' }
    'PSScriptAnalyzer' = @{ DependencyType = 'PSGalleryNuget' }
}