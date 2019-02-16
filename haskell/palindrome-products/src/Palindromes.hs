module Palindromes (largestPalindrome, smallestPalindrome) where

import Data.List
import Data.Maybe

type Prods = (Integer, [(Integer, Integer)])

isPalindrome :: Integer -> Bool
isPalindrome n = s == reverse s
    where s = show n

allPalindromes :: Integer -> Integer -> [Prods]
allPalindromes minFactor maxFactor = [(x*y,[(x,y)]) | x <- [minFactor..maxFactor], y <- [x..maxFactor], isPalindrome (x*y)]

ordTuple :: Prods -> Prods -> Ordering
ordTuple a b = compare (toCp a) (toCp b)
    where toCp (n, _) = n

funcPalindrome :: ((Prods -> Prods -> Ordering) -> [Prods] -> Prods) -> Integer -> Integer -> Maybe Prods
funcPalindrome funcList minFactor maxFactor = getMaybeElement $ allPalindromes minFactor maxFactor
    where 
        getMaybeElement :: [Prods] -> Maybe Prods
        getMaybeElement [] = Nothing
        getMaybeElement xs = Just $ (el, map (head . snd) $ filter (\x -> fst x == el) xs)
                where 
                  tuples = funcList ordTuple xs
                  (el, _) = tuples



largestPalindrome :: Integer -> Integer -> Maybe Prods
largestPalindrome = funcPalindrome maximumBy

smallestPalindrome :: Integer -> Integer -> Maybe Prods
smallestPalindrome = funcPalindrome minimumBy
