class ArrayOrderTransforms {
    
    static [string[]] AsReversed (
        [string[]] $items
    ) {
        $reversed = [System.Collections.Generic.List[string]]::new($items)
        $reversed.Reverse()
        return $reversed.ToArray()
    }
    
    static [string[]] AsPreserved (
        [string[]] $items
    ) {
        return $items.Clone()
    }
    
    # Identity -> 保持原樣; NoReorder -> 不重排; AsIs -> 原封不動
    static [string[]] Identity (
        [string[]] $items
    ) {
        return $items.Clone()
    }
    
}