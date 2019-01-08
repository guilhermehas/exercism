module ETL (transform) where

import Data.Map (Map, empty, union, insert, toList)
import Data.Char (toLower)

transform :: Map a String -> Map Char a
transform = foldr newDictFromOld empty . toList

transformFromPoint :: a -> String -> Map Char a
transformFromPoint _  "" = empty
transformFromPoint point s = insert (toLower $ head s) point $ transformFromPoint point $ tail s

newDictFromOld :: (a, String) -> Map Char a -> Map Char a
newDictFromOld (point, s) = union $ transformFromPoint point s
