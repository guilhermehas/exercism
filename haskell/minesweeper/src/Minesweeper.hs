module Minesweeper (annotate) where

import Data.Char (intToDigit)
import Data.Matrix (Matrix, (!), safeGet, setElem, fromLists, nrows, ncols, getRow)
import Data.Vector (toList)

countBombs :: Matrix Char -> (Int, Int) -> Int
countBombs mat (x,y) = length $ filter (== Just '*') $ map safeGet' neigs
    where neigs = [(x+dx, y+dy) | dx <- [-1..1], dy <- [-1..1], (dx,dy) /= (0,0)]
          safeGet' :: (Int,Int) -> Maybe Char
          safeGet' (x', y') = safeGet x' y' mat

charToBomb :: Matrix Char -> (Int, Int) -> Char
charToBomb mat index =
    case mat ! index of
      '*' -> '*'
      _ -> let nbombs = countBombs mat index in
               case nbombs of
                 0 -> ' '
                 _ -> intToDigit nbombs

mArray :: Int -> [Int]
mArray n
    | n <= 0 = []
    | otherwise = [1..n]

modifyMatrix :: (Matrix a -> (Int,Int) -> a) -> Matrix a -> Matrix a
modifyMatrix f mat = foldr setElem' mat indexes
    where indexes = [(x,y) | x <- mArray (nrows mat), y <- mArray (ncols mat) ]
          setElem' index mat' = setElem (f mat' index) index mat'

matToList :: Matrix a -> [[a]]
matToList mat = map (toList . flip getRow mat) $ mArray $ nrows mat

annotate :: [String] -> [String]
annotate [] = []
annotate board = matToList $ modifyMatrix charToBomb $ fromLists board
