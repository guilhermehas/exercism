module Scrabble (scoreLetter, scoreWord) where

import Data.Char

score :: Char -> [String] -> [Integer] -> Integer
score _ [] [] = 0
score _ [] _ = error "not valid case"
score _ _ [] = error "not valid case"
score ch (s : sx) (p : ps) = if ch `elem` s then p else score ch sx ps

scoreLetter :: Char -> Integer
scoreLetter letter = score (toLower letter) letters points
    where
        letters = ["aeioulnrst","dg", "bcmp", "fhvwy", "k", "jx", "qz"]
        points = [1, 2, 3, 4, 5, 8, 10]

scoreWord :: String -> Integer
scoreWord = sum . map scoreLetter
