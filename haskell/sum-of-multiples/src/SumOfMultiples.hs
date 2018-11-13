module SumOfMultiples (sumOfMultiples) where

isDividend :: Integer -> [Integer] -> Bool
isDividend n vet = or $ map (\x -> n `mod` x == 0) vet

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum [x | x <- [1..limit-1], isDividend x factors]
