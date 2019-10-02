Function Set-KubeNs
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ArgumentCompleter( {
                param($command, $parameter, $wordToComplete, $commandAst, $fakeBoundParams)
                Get-KubeNsName
            }
        )]
        [ValidateScript( {
                $_ -in (Get-KubeNsName)
            }
        )]
        [String] $NameSpace
    )
    kubectl config set-context --current --namespace=$NameSpace
}
