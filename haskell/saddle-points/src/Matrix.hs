module Matrix (saddlePoints) where

import Data.Array
import Data.Foldable
import Data.Maybe
import qualified Data.Set as Set

bestOf :: Ix i => Eq e => Array i e -> (e -> e -> e) -> i -> [i] -> [i]
bestOf array f ind [] = [ind]
bestOf array f ind2 (ind1:ys)
  | v == v1 && v == v2 = ind2:xs
  | v == v1 = xs
  | otherwise = [ind2]
    where v1 = array ! ind1
          v2 = array ! ind2
          v = f v1 v2
          xs = ind1:ys

bestTupple :: Ix i => Eq e => Array i e -> (e -> e -> e) -> [i] -> [i]
bestTupple array f = foldr (bestOf array f) []

toSet :: Ix i => Eq e => Array i e -> (e -> e -> e) -> [[i]] -> Set.Set i
toSet matrix f = Set.fromList . concatMap (bestTupple matrix f)

saddlePoints :: Array (Int,Int) Int -> [(Int,Int)]
saddlePoints matrix = Set.toList $ Set.intersection rows columns
    where ((bsx, bsy), (bex, bey)) = bounds matrix
          bxs = [[(x,y) | y <- [bsy..bey]] | x <- [bsx..bex]]
          bys = [[(x,y) | x <- [bsx..bex]] | y <- [bsy..bey]]
          toSet' = toSet matrix
          rows = toSet' max bxs
          columns = toSet' min bys


