module WordCount (wordCount) where

import Data.List
import Data.Char

subsLetter :: Char -> Char
subsLetter ch
  | isAlpha ch || isDigit ch || ch `elem` "'" = toLower ch
  | otherwise = ' '

subsWords :: String -> String
subsWords s
  | null s = s
  | head s == head "'" = subsWords $ tail s
  | last s == head "'" = subsWords $ init s
  | otherwise = s
    

wordCount :: String -> [(String, Int)]
wordCount = map (\g -> (head g, length g)) . group . sort . map subsWords . words . map subsLetter
