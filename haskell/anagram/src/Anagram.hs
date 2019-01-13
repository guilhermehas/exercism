module Anagram (anagramsFor) where

import Data.List
import Data.Char

isAnagram :: String -> String -> Bool
isAnagram ks ksx = s /= sx && sort s == sort sx
    where s = map toLower ks
          sx = map toLower ksx

toListBool :: String -> String -> [String] -> [String]
toListBool word cword v
  | isAnagram word cword = cword : v
  | otherwise = v

anagramsFor :: String -> [String] -> [String]
anagramsFor xs = foldr (toListBool xs) []
