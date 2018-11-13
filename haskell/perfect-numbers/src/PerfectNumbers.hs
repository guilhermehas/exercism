module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify x
  | x <= 0 = Nothing
  | sfactors  < x = Just Deficient
  | sfactors == x = Just Perfect
  | sfactors  > x = Just Abundant
   where
        sfactors = sum [y | y <- [1..(x-1)], x `mod` y == 0]

