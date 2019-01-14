module Series (Error(..), largestProduct) where

import Data.Char
import Data.List

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn chr = unfoldr sep where
  sep [] = Nothing
  sep l  = Just . fmap (drop 1) . break (== chr) $ l

largestProductNotZero' :: [Int] -> [Int] -> Int -> Int
largestProductNotZero' _ [] n = n
largestProductNotZero' [] _ _ = error "Impossible case"
largestProductNotZero' (x:xs) (y:ys) n = max n (largestProductNotZero' xs ys (n*y `div` x))

largestProductNotZero :: Int -> [Int] -> Int
largestProductNotZero n xs = largestProductNotZero' xs (drop n xs) (product (take n xs))

largestProduct :: Int -> String -> Either Error Integer
largestProduct size digits
    | size < 0 || size > length digits = Left InvalidSpan
    | not $ null notDigits = Left $ InvalidDigit $ head notDigits
    | otherwise = Right $ toInteger $ largestProductInteger size $ map digitToInt digits
        where notDigits = filter (not . isDigit) digits

largestProductInteger :: Int -> [Int] -> Int
largestProductInteger size digits
  | size == 0 = 1
  | null nonZeroParts = 0
  | otherwise = foldr max 0 $ map (largestProductNotZero size) nonZeroParts
  where 
      nonZeroParts = (filter (\x -> length x >= size) . splitOn 0) digits
