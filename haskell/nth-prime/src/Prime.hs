module Prime (nth) where

primeFromList :: [Integer] -> Integer
primeFromList [] = 2
primeFromList xs = (+1) $ last $ hxs-1 : takeWhile (\cand -> not $ all (\p -> cand `mod` p /= 0) xs) [hxs..]
    where hxs = head xs + 1

newPrime :: [Integer] -> [Integer]
newPrime xs = primeFromList xs : xs

nth :: Int -> Maybe Integer
nth n
    | n <= 0 = Nothing
    | otherwise = Just $ head $(iterate newPrime []) !! n
