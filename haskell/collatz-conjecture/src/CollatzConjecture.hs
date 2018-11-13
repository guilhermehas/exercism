module CollatzConjecture (collatz) where

collAux :: Integer -> Integer -> Integer
collAux 1 k = k
collAux n k
  | n `mod` 2 == 0 = collAux (n `div` 2) k+1
  | otherwise = collAux (3*n+1) k+1


collatz :: Integer -> Maybe Integer
collatz n = if n > 0 then Just $ collAux n 0 else Nothing
