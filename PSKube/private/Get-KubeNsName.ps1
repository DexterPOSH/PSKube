function Get-KubeNsName {
    [CmdletBinding()]
    param()
    
    $NS = kubectl get namespace -o json | ConvertFrom-Json
    if ($NS.Items.length -gt 0 ) {
        return (
            $NS.Items.Foreach({$PSitem.metadata.name})
        )
    }
}