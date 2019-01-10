module Triangle (TriangleType(..), triangleType) where

import Data.List

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Illegal
                  deriving (Eq, Show)



triangleType :: (Num a) => (Ord a) => a -> a -> a -> TriangleType
triangleType an bn cn
  | c >= a + b = Illegal
  | a <= 0 = Illegal
  | a == b && b == c = Equilateral
  | a == b || b == c = Isosceles
  | otherwise = Scalene
  where
    [a, b, c] = sort [an,bn,cn]
