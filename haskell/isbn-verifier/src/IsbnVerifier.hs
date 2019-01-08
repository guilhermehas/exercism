module IsbnVerifier (isbn) where

import Data.Char
import Control.Monad


isDash x = x == '-'
sizeRight s = length s == 13
withDashes s =  all isDash [s !! i | i <- [1, 5, 11]]
removeDashes = filter (\x -> isDigit x || x == 'X')
toNumber ch = if ch == 'X' then 10 else ord ch - ord '0' 

-- "3-598-21508-8"
isbn :: String -> Bool
isbn s = Nothing /= do
    guard $ length s == 13
    guard $ withDashes s || length s == 10
    let s2 = removeDashes s
    guard $ length s2 == 10
    let sn = sum [x*y | x <- map toNumber s2, y <- [10,9..1]]
    guard $ sn `mod` 11 == 0
    guard $ all isDigit $ init s2

kkk x = Nothing /= do
    guard $ x == 0
