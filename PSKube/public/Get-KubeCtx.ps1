function Get-KubeCtx {
    [CmdletBinding()]
    param()
    $(kubectl config get-contexts -o name)
}
