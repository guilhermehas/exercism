module Acronym (abbreviate) where

import Data.Char (toUpper)

replace :: Char -> Char -> [Char] -> [Char]
replace a b s = map (\c -> if c == a then b else c) s

abbreviate :: String -> String
abbreviate xs = 
    let 
        new_xs = replace ',' ' ' $ replace '-' ' ' $ replace '.' ' ' xs
    in
        map toUpper $ concat $ map (take 1) $ words new_xs
