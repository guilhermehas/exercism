module Diamond (diamond) where

import Data.Char

toInt :: Char -> Int
toInt c = ord c - ord 'A'

spaces :: Int -> String
spaces n = [' '| _ <- [1..n]]

getLineF :: Int -> Char -> String
getLineF size 'A' = spaceBefore ++ ['A'] ++ spaceBefore
    where spaceBefore = spaces size

getLineF size c = spaceBefore ++ [c] ++ spaces sizeSpaceMiddle ++ [c] ++ spaceBefore
    where cn = toInt c
          sizeSpaceBefore = size - cn
          spaceBefore = spaces sizeSpaceBefore
          sizeSpaceMiddle = 2 * (size - sizeSpaceBefore) - 1

diamond :: Char -> Maybe [String]
diamond c = Just $ lines ++ (reverse . init) lines
    where size = toInt c
          lines = [getLineF size l | l <- ['A'..c]]
