function Get-KubeSecret {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory= $false)]
        [String] $Name
    )
    
    if ($name) {
        return (kubectl get secret $Name -o json | ConvertFrom-Json)
    }
    else {
        return (kubectl get secret -o json | ConvertFrom-Json).Items
    }
}