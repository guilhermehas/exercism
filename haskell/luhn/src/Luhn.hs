module Luhn (isValid) where

import Data.Char
import Data.List
import Data.List.Split

dupDigit :: Int -> Int
dupDigit n = 2*n + if 2*n >= 10 then 1 else 0

dup :: [[Int]] -> Int
dup [] = 0
dup (xs:[]) = sum xs
dup (xs:ys:[]) = sum xs + sum (map dupDigit ys)
dup _ = error "Invalid case"

isValid :: String -> Bool
isValid = isValidSpace . filter (/= ' ')

isValidSpace :: String -> Bool
isValidSpace [] = False
isValidSpace (_:[]) = False
isValidSpace xs = (isDiv10 . dup . transpose . chunksOf 2 . map digitToInt . reverse) xs
    where isDiv10 n = n `mod` 10 == 0
