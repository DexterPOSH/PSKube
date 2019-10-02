function Get-KubeNs
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [String] $NameSpace
    )
    
    process
    {
        $NS = kubectl get namespace -o json | ConvertFrom-Json
        if ($NS.Items.length -gt 0)
        {
            foreach ($item in $NS.Items) {
                $item |
                    Add-Member -MemberType NoteProperty -Name Name -Value $item.metadata.Name -PassThru |
                    Add-Member -MemberType NoteProperty -Name CreationTime -Value $item.metadata.creationTimestamp -PassThru
            }
        }
        else {
            Write-Warning -Message "Kubectl get namespace returned nothing"
        }
    }
}