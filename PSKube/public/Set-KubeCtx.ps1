function Set-KubeCtx {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .NOTES
        https://vexx32.github.io/2018/11/29/Dynamic-ValidateSet/

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ArgumentCompleter(
            {
                param($command, $parameter, $wordToComplete, $commandAst, $fakeBoundParams)
                Get-KubeCtx
            }
        )]
        [ValidateScript(
            {
                $_ -in (Get-KubeCtx)
            }
        )]
        [String] $Context,

        [Parameter(Mandatory = $false)]
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
    
    begin {
        $Current = kubectl config current-context
    }
    
    process {
        if ($Current -eq $Context) {
            Write-Verbose -Message "Current Context is already set to specied context..."
            
        }
        else {
            Write-Verbose -Message "Setting the specified context..."
            kubectl config use-context $Context
        }
        if ($NameSpace) {
            Write-Verbose -message "Modifying the current context namespace..."
            Set-KubeNs -NameSpace $NameSpace
        }
    }
    
    end {
    }
}
