module RailFenceCipher (encode, decode) where

import Data.List

nextStep :: Int -> (Int, Int, Bool) -> (Int, Int, Bool)
nextStep n (x, y, dy) = (x+1, y', dy')
    where
        (y', dy')
          | y == 0 = (1, True)
          | y == n = (n-1, False)
          | otherwise = (y + if dy then 1 else -1, dy)


encode :: Int -> String -> String
encode n sentence = map fst $ sortOn toTuple vletters
    where 
        positions = iterate (nextStep $ n - 1) (0,0,True)
        vletters = zip sentence positions
        toTuple (_, (x,y,_)) = (y,x)

decode :: Int -> String -> String
decode n str = map snd . sortOn fst . zip (encode n (take (length str) ['a'..])) $ str
