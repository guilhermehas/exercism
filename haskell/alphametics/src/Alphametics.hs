{-# LANGUAGE ScopedTypeVariables #-}

module Alphametics (solve) where

import Data.List
import Data.List.Split
import Data.Maybe

getSolution :: [(a, Int)] -> [(a,[Int])] -> ([(a, Int)] -> Bool) -> Maybe [(a, Int)]
getSolution pairs [] isPairsRight = if isPairsRight pairs then Just pairs else Nothing
getSolution pairs ((v, poss):possiblePairs) isPairsRight = 
    listToMaybe
  $ map fromJust 
  $ filter isJust 
  $ map (\x -> getSolution ((v,x):pairs) (getNewPairs x possiblePairs) isPairsRight) poss
      where getNewPairs x = map (\(pstart, rposs) -> (pstart, filter (/= x) rposs))

isPairsRight :: forall a. Eq a => [[a]] -> [a] -> [(a, Int)] -> Bool
isPairsRight leftWords rightWord pontuation = sum (map pont leftWords) == pont rightWord
    where
        toPont letter = snd $ fromJust $ find (\(l, _) -> l == letter) pontuation
        accSum letter (sum', pot) = (toPont letter * pot + sum', pot*10)
        pont :: Eq a => [a] -> Int
        pont = fst . foldr accSum (0,1)

possiblePontuations :: Eq a => [[a]] -> [(a, [Int])]
possiblePontuations words = [(l, [1..9]) | l <- fletters] ++ [(l, [0..9]) | l <- sletters]
    where fletters = nub $ map head words
          sletters = (nub $ concat $ map tail words) \\ fletters


parse :: String -> ([String], String)
parse sentence = (fsents, ssents)
    where 
        sents = splitOn " == " sentence
        fsents = splitOn " + " $ head sents
        ssents = last sents

solve :: String -> Maybe [(Char, Int)]
solve puzzle = getSolution [] pontuations isPairsRight'
    where 
        (fwords, lword) = parse puzzle
        allWords = fwords ++ [lword]
        pontuations = possiblePontuations $ allWords
        isPairsRight' = isPairsRight fwords lword
