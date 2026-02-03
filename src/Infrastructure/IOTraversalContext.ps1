class IOTraversalContext {
    
    [System.Collections.Generic.LinkedList[string]] $Nodes
    
    IOTraversalContext () {
        $this.Nodes = [System.Collections.Generic.LinkedList[string]]::new()
    }
    
}