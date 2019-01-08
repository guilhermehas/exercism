module Isogram (isIsogram) where

import Data.List
import Data.Char

rmdups :: (Ord a) => [a] -> [a]
rmdups = map head . group

isIsogram :: String -> Bool
isIsogram sn = rmdups s == s
    where s = filter isLetter . sort . map toLower $ sn
