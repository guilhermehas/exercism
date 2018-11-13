module Pangram (isPangram) where

import Data.Char

isMember n [] = False
isMember n (x:xs)
    | n == x = True
    | otherwise = isMember n xs

isAllIn v1 v2 = and $ map (\x -> isMember x v2) v1

isPangram :: String -> Bool
isPangram text =  isAllIn ['a'..'z'] $ map toLower $ filter (\x -> x/= ' ') text
