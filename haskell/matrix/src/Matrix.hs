module Matrix
    ( Matrix
    , cols
    , column
    , flatten
    , fromList
    , fromString
    , reshape
    , row
    , rows
    , shape
    , transpose
    ) where

import Data.Vector (Vector, (!))
import qualified Data.Vector as Vector
import Data.List.Split
import qualified Data.List as List

data Matrix a = Matrix (Vector (Vector a)) deriving (Eq, Show)

toVector :: Matrix a -> Vector (Vector a)
toVector (Matrix m) = m

cols :: Matrix a -> Int
cols (Matrix matrix) = length (matrix ! 0)

column :: Int -> Matrix a -> Vector a
column x = Vector.map (\line -> line ! x) . toVector

flatten :: Matrix a -> Vector a
flatten = Vector.fromList . concat . toList

fromList :: [[a]] -> Matrix a
fromList = Matrix . Vector.fromList . map Vector.fromList

toList :: Matrix a -> [[a]]
toList = Vector.toList . Vector.map Vector.toList . toVector

fromString :: Read a => String -> Matrix a
fromString = fromList . map (map read . splitOn " ") . filter (/= "") . splitOn "\n"

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape (n, _) = fromList . chunksOf n . Vector.toList . flatten

row :: Int -> Matrix a -> Vector a
row x (Matrix matrix) = matrix ! x

rows :: Matrix a -> Int
rows = Vector.length . toVector

shape :: Matrix a -> (Int, Int)
shape (Matrix matrix)
  | lm == 0 = (0,0)
  | otherwise = (lm, Vector.length $ matrix ! 0)
    where lm = Vector.length matrix

transpose :: Matrix a -> Matrix a
transpose = fromList . List.transpose . toList
