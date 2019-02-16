module Spiral (spiral) where

import Data.List

spiralRet :: Int -> Int -> Int -> [[Int]]
spiralRet 0 _ _ = []
spiralRet _ 0 _ = []
spiralRet n m begin = [begin..begin+m-1] : (map reverse . transpose) newSpiral
    where newSpiral = spiralRet m (n-1) (begin+m)

spiral :: Int -> [[Int]]
spiral size = spiralRet size size 1
