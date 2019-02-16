module Sublist (Sublist(..), sublist) where

import Data.List

data Sublist = Equal | Sublist | Superlist | Unequal deriving (Eq, Show)

isSub :: Eq a => [a] -> [a] -> Bool
isSub [] _ = True
isSub _ [] = False
isSub xs ys = isPrefixOf xs ys || isSub xs (tail ys)

sublist :: Eq a => [a] -> [a] -> Sublist
sublist xs ys
  | length xs == length ys = if isSub xs ys then Equal else Unequal
  | length xs < length ys = if isSub xs ys then Sublist else Unequal
  | otherwise = if isSub ys xs then Superlist else Unequal
