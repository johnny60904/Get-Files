class IOTraversalContextExtractionDispatcher {
    
    static [ScriptBlock] Dispatch (
        [TraversalStrategy] $strategy
    ) {
        switch ($strategy) {
            DepthFirst { # DFS
                return [IOTraversalContextExtraction]::ExtractLast
            }
            BreadthFirst { # BFS
                return [IOTraversalContextExtraction]::ExtractFirst
            }
            default {
                throw [System.InvalidOperationException]::new(
                    'Unknown traversal strategy in Dispatch.'
                )
            }
        }
        # Unreachable
        throw [System.InvalidOperationException]::new(
            'Unreachable code path in Dispatch.'
        )
    }
    
}