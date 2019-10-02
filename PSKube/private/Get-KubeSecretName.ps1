function Get-KubeSecretName {
    [CmdletBinding()]
    param()
    
    return (kubectl get secret -o name |
                    ForEach-Object -Process {
                        ($PSItem -Split '/')[1]
                    }
    )
}