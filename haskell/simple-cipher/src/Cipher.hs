module Cipher (caesarDecode, caesarEncode, caesarEncodeRandom) where

import Data.Char
import Control.Monad
import System.Random

zadif :: Int
zadif = ord 'z' - ord 'a' + 1

rem' :: Int -> Int -> Int
m `rem'` n = ((m `mod` n) + n) `mod` n

moda :: Int -> Int
moda n = ((n - ord 'a') `rem'` zadif) + ord 'a'

caesarDecode :: String -> String -> String
caesarDecode key  = caesarEncode $ map (\l -> chr $ moda $ zadif - ord l + 2 * ord 'a') key

caesarEncode :: String -> String -> String
caesarEncode key = zipWith (\k l -> chr $ moda $ ord l + ord k - ord 'a') (cycle key)

caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
    keys <- replicateM (length text) $ randomRIO ('a','z')
    return (keys, caesarEncode keys text)
