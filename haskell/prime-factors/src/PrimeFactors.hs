module PrimeFactors (primeFactors) where

fstc :: (a->Bool) -> [a] -> a
fstc _ [] = error "Impossible case"
fstc f (x:xs) = if f x then x else fstc f xs

firstPrime :: Integer -> Integer
firstPrime n = fstc (\x -> n `mod` x == 0)[2..n]

primeFactors :: Integer -> [Integer]
primeFactors 1 = []
primeFactors n = p : primeFactors (n `div` p)
    where p = firstPrime n
