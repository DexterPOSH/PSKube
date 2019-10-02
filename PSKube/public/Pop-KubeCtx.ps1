function Pop-KubeCtx {
    
    if ($Global:KubeCtxName) {
        kubectl config use-context $Global:KubeCtxName
    }
    else {
        Write-Warning -Message "Nothing in the KubeCtxName var to pop..."
    }
}
