function Start-TillerOnLocalHost {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ArgumentCompleter(
            {
                param($command, $parameter, $wordToComplete, $commandAst, $fakeBoundParams)
                Get-KubeNsName
            }
        )]
        [ValidateScript(
            {
                $_ -in (Get-KubeNsName)
            }
        )]
        [String] $NameSpace,

        [Parameter()]
        [Int] $Port = 44134
    )
    
    begin {
        # check that tiller binary is available
        $null = Get-Command -Name tiller -ErrorAction Stop
        # Check that kubectl binary is available
        $null = Get-Command -Name kubectl -ErrorAction Stop
        if ( -not (Kubectl get namespace $NameSpace)) {
            throw "Could not find specified namespace with current kube context..."
        }
    }
    process {
        try {
            # Set the env vars
            $env:TILLER_NAMESPACE=$NameSpace;
            $env:HELM_HOST="localhost:$($Port)";
            # Start a background Job running Tiller locally
            $Null = Start-Job -Name TillerOnLocalHost -ScriptBlock {
                tiller --storage=secret;
            } -ErrorAction Stop
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
}