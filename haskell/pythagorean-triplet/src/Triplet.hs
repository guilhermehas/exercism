module Triplet (tripletsWithSum) where

import Data.List
import Data.Maybe

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = x:unique (filter ((/=) x) xs)

sortUniq :: Eq a => Ord a => [a] -> [a]
sortUniq = unique . sort

transfTriple :: (Int,Int,Int) -> Maybe (Int,Int,Int)
transfTriple (a, b, c)
  | a' > 0 && a' ** 2 + b'^2 == c'^2 = Just (a',b',c')
  | otherwise = Nothing
    where [a', b', c'] = sort [a,b,c]

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum sum = sortUniq $ mapMaybe transfTriple [(x,y,sum-x-y) | x <- [1..sum-2] , y <- [x..sum-2] ]
