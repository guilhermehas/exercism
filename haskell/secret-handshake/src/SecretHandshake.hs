module SecretHandshake (handshake) where

toBin :: Int -> (Bool, [Bool])
toBin n = (isPot 4 n, [isPot k n | k <- [0..3]])
    where isPot k n = (n `div` 2 ^ k) `mod` 2 == 1

mapBool :: [Bool] -> [String] -> [String]
mapBool [] [] = []
mapBool _ [] = error "impossible case"
mapBool [] _ = error "impossible case"
mapBool (False:bs) (_:xs) = mapBool bs xs
mapBool (True:bs) (s:xs) = s : mapBool bs xs

rev :: Bool -> ([a] -> [a])
rev False = id
rev True = reverse

handshake :: Int -> [String]
handshake n = (rev shouldReverse) $ mapBool bins ["wink", "double blink", "close your eyes", "jump"]
    where (shouldReverse, bins) = toBin n

