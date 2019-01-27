module CryptoSquare (encode) where

import Data.Char
import Data.List
import Data.List.Split


encode :: String -> String
encode sn = unwords $ transpose $ map addAtEnd $ chunksOf size s
    where s = map toLower $ filter (\x -> isDigit x || isAlpha x) sn
          size = ceiling $ sqrt $ fromIntegral $ length s
          addAtEnd sm = sm ++ replicate (size - length sm) ' '

