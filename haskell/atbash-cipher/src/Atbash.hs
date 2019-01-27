module Atbash (decode, encode) where

import Data.Char
import Data.List.Split
import Data.List

modLetter :: Char -> Char
modLetter l
  | isAlpha l = chr $ ord 'z' + ord 'a' - ord (toLower l)
  | otherwise = l

modString :: String -> String
modString = map modLetter

decode :: String -> String
decode = filter (\x -> isAlpha x || isDigit x) . modString

encode :: String -> String
encode = intercalate " " . chunksOf 5 . decode
