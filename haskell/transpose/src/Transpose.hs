module Transpose (transpose) where

import Data.Maybe

mapConcat :: [Maybe a] -> [a]
mapConcat [] = []
mapConcat ((Just x) : xs) = x : mapConcat xs
mapConcat (Nothing : xs) = mapConcat xs

addSpace :: Int -> [String] -> [String]
addSpace _ [] = []
addSpace n (x:xs)
  | n > lx = (x ++ replicate (n - lx) ' ') : xs'
  | otherwise = x : xs'
    where lx = length x
          n' = max lx n
          xs' = addSpace n' xs


transpose :: [String] -> [String]
transpose [] = []
transpose mat' = mapConcat (map listToMaybe mat) : transpose (filter (/= "") $ map tail mat)
    where mat = reverse $ addSpace 0 $ reverse mat'

