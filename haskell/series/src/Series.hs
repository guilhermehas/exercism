module Series (slices) where

import Data.List
import Data.Char
import Data.Maybe

toSize :: Int -> String -> Maybe String
toSize n str
  | length str >= n = Just $ take n str
  | otherwise = Nothing

slices :: Int -> String -> [[Int]]
slices n = mapMaybe (fmap (map digitToInt) . toSize n) . tails
