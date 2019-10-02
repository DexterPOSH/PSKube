function Get-KubeDecodedSecret {
    [CmdletBinding()]
    param (
        # Specify the name of the Secret to decode
        [Parameter(Mandatory = $true)]
        [ArgumentCompleter(
            {
                param($command, $parameter, $wordToComplete, $commandAst, $fakeBoundParams)
                Get-KubeSecretName
            }
        )]
        [ValidateScript(
            {
                $_ -in (Get-KubeSecretName)
            }
        )]
        [String] $Secret
    )
    
    begin {
        $null = Get-Command -Name kubectl -ErrorAction Stop
        $currentContext = kubectl config current-context
        if (-not $currentContext) {
            throw "K8s Context not set..."
        }
    }
    
    process {
        $secretsObject = kubectl get secrets $Secret -o json | ConvertFrom-Json
        $secretsObject.data.psobject.Properties | 
        Select-Object -Property Name,@{
            L='Value';
            E={[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Psitem.Value))}}
    }
    
    end {
    }
}