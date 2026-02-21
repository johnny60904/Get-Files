class StringSetOperations {

    static [string[]] Distinct (
        [string[]] $array
    ) {

        $set = [System.Collections.Generic.HashSet[string]]::new()
        $result = [System.Collections.Generic.List[string]]::new()

        foreach ($item in $array) {
            if ($set.Add($item)) {
                $result.Add($item)
            }
        }

        return $result.ToArray()
    }

}