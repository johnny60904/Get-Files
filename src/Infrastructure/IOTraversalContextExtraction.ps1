class IOTraversalContextExtraction {
    
    # DFS
    static [ScriptBlock] $ExtractLast = {
        param(
            [IOTraversalContext] $context
        )
        $value = $context.Nodes.Last.Value
        $context.Nodes.RemoveLast()
        return $value
    }
    
    # BFS
    static [ScriptBlock] $ExtractFirst = {
        param(
            [IOTraversalContext] $context
        )
        $value = $context.Nodes.First.Value
        $context.Nodes.RemoveFirst()
        return $value
    }
    
}