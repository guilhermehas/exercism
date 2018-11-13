module ArmstrongNumbers (armstrong) where

numDigits :: Integer -> Integer
numDigits n = toInteger (round (logBase 10 (fromIntegral n)) + 1)

toDigits :: Integral a => a -> [a]
toDigits n
    | n == 0 = []
    | otherwise = (mod n 10) : toDigits (div n 10)

armstrong :: Integral a => a -> Bool
armstrong n =
    n == k
    where 
        digits = toDigits n
        k = sum $ map (\x -> x ^ (length digits)) digits
