module Triangle (rows) where

rowFromBefore :: [Integer] -> [Integer]
rowFromBefore xs = 1 : [x+y | (x,y) <- zip xs (tail xs)] ++ [1]

rowsInf :: [Integer] -> [[Integer]]
rowsInf xs = xs : rowsInf (rowFromBefore xs)

rows :: Int -> [[Integer]]
rows n = take n $ rowsInf [1]
