module DNA (toRNA) where

transfLetter :: Char -> Char
transfLetter ch = case ch of
                    'G' -> 'C'
                    'C' -> 'G'
                    'T' -> 'A'
                    'A' -> 'U'
                    _ -> ' '

toRNA :: String -> Maybe String
toRNA xs = 
    let rna = map transfLetter xs
     in if any (== ' ') rna then Nothing else Just rna
