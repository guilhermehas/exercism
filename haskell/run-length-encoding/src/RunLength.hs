module RunLength (decode, encode) where

import Data.Char
import Data.List

splitDigits :: String -> [String] -> String -> [String]
splitDigits "" answer "" = answer
splitDigits cache answer "" = splitDigits "" (cache : answer) ""
splitDigits cache answer sentence = 
    let
        firstLetter = head sentence
        sfirstLetter = charToString firstLetter
        rsentence = tail sentence
     in case () of
      _ | isDigit firstLetter -> splitDigits (firstLetter : cache) answer rsentence
        | cache == "" -> splitDigits "" (sfirstLetter : answer) rsentence
        | otherwise -> splitDigits "" (sfirstLetter : cache : answer) rsentence


type CharInt = Either Char Int

toFormat :: String -> CharInt
toFormat s
  | isDigit $ head s = Right $ read s
  | otherwise = Left $ head s

toArrayDigits :: [CharInt] -> [(Int,Char)]
toArrayDigits [] = []
toArrayDigits ((Left ch) : []) = [(1, ch)]
toArrayDigits ((Right _) : _) = error "Impossible Case"
toArrayDigits ((Left ch1) : (Left ch2) : xs) = (1, ch1) : (toArrayDigits $ (Left ch2) : xs)
toArrayDigits ((Left ch) : (Right n) : xs) = (n, ch) : toArrayDigits xs

arrayDigitsToString :: [(Int,Char)] -> String
arrayDigitsToString [] = ""
arrayDigitsToString ((n,ch) : xs) = (take n $ repeat ch) ++ arrayDigitsToString xs

decode :: String -> String
decode = reverse . arrayDigitsToString . toArrayDigits . map (toFormat . reverse) . splitDigits "" []

charToString :: Char -> String
charToString c = [c]

joinFuncs :: (a -> String) -> (a -> String) -> a -> String
joinFuncs f g v = f v ++ g v

showNumber :: Int -> String
showNumber 1 = ""
showNumber n = show n

encode :: String -> String
encode = concat . map (joinFuncs (showNumber . length) (charToString . head)) . group

