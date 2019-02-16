module RotationalCipher (rotate) where

import Data.Char

rotateNumber :: Int -> Int -> Int
rotateNumber k n
  | inLetter 'A' = rot 'A'
  | inLetter 'a' = rot 'a'
  | otherwise = n
    where qtl = ord 'z' - ord 'a' + 1
          rot l = (n + k + qtl - ord l) `mod` qtl + ord l
          inLetter l = ord l <= n && ord l + qtl > n

rotate :: Int -> String -> String
rotate n = map (chr . rotateNumber n . ord)
