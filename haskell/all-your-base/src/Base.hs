module Base (Error(..), rebase) where

import Data.List (find)

data Error a = InvalidInputBase | InvalidOutputBase | InvalidDigit a
    deriving (Show, Eq)

toNum' :: Integral a => a -> a -> [a] -> a
toNum' _ _ [] = 0
toNum' base nbase (x:xs) = nbase * x + toNum' base (nbase*base) xs

toNum :: Integral a => a -> [a] -> a
toNum base = toNum' base 1 . reverse

toVet' :: Integral a => a -> a -> [a]
toVet' _ 0 = []
toVet' base n = n `mod` base : toVet' base (n `div` base)

toVet :: Integral a => a -> a -> [a]
toVet base n = reverse $ toVet' base n

rebase :: Integral a => a -> a -> [a] -> Either (Error a) [a]
rebase inputBase outputBase inputDigits
    | inputBase <= 1 = Left InvalidInputBase
    | outputBase <= 1 = Left InvalidOutputBase
    | otherwise = let firstWrong = find (\x -> x < 0 || x >= inputBase) inputDigits in
          case firstWrong of
            Just wrong -> Left $ InvalidDigit wrong
            Nothing -> Right $ toVet outputBase $ toNum inputBase inputDigits
