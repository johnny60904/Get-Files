class CollectionsMerger {
    
    static [string[]] ConcatStringArray ( # 不去重
        [object[]] $collections # @(string[], string[], ...)
    ) {
        $merged = [System.Collections.Generic.List[string]]::new()
        for ($i = 0; $i -lt $collections.Length; $i ++) {
            $merged.AddRange($collections[$i])
        }
        return $merged.ToArray()
    }
    
    static [string[]] UnionStringSet ( # 去重
        [object[]] $collections # @(string[], string[], ...)
    ) {
        $set = [System.Collections.Generic.HashSet[string]]::new()
        for ($i = 0; $i -lt $collections.Length; $i ++) {
            $set.UnionWith($collections[$i])
        }
        $iEnum = [System.Collections.Generic.IEnumerable[string]]$set
        return [System.Linq.Enumerable]::ToArray($iEnum)
    }
    
    static [string] JoinStringArray (
        [string[]] $array,
        [string] $separator
    ) {
        return [System.String]::Join($separator, $array)
    }
    
}