module Change (findFewestCoins) where

import Data.Array((!), listArray, Array)
-- import Debug.Trace

bestSolution :: Maybe [Integer] -> Maybe [Integer] -> Maybe [Integer]
bestSolution Nothing s = s
bestSolution s Nothing = s
bestSolution (Just sol1) (Just sol2) = if s1 < s2 then Just sol1 else Just sol2
    where s1 = sum sol1
          s2 = sum sol2

addOneNth :: Int -> [Integer] -> [Integer]
addOneNth _ [] = []
addOneNth n (x:xs)
    | n == 0 = (x+1):xs
    | otherwise = x:addOneNth (n-1) xs

accVec :: [Integer] -> [Integer] -> [Integer]
accVec [] [] = []
accVec (n:ns) (c:xs) = replicate (fromIntegral n) c ++ accVec ns xs
accVec _ _ = error "Impossible case"

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins target coins = fmap (flip accVec coins) $ rec (toInteger lcoins - 1) target
    where
        lcoins = length coins

        sizeArray = lcoins * (fromIntegral target + 1)
        vcoins :: Array Int (Maybe [Integer])
        vcoins = listArray (0,sizeArray) (map g [0..sizeArray])
        f :: Integer -> Integer -> Maybe [Integer]
        f c v
           -- | trace ("c: " ++ show c ++ " v: " ++ show v) False = undefined
            | v < 0 = Nothing
            | v == 0 = Just $ replicate lcoins 0
            | c < 0 = Nothing
            | otherwise = let 
                              s1 :: Maybe [Integer]
                              s1 = rec (c-1) v

                              c' = fromIntegral c
                              s2 :: Maybe [Integer]
                              s2 = fmap (addOneNth c') $ rec c $ v - coins !! c'
                           in bestSolution s1 s2
                
        rec :: Integer -> Integer -> Maybe [Integer]
        rec i j
         -- | trace ("i: " ++ show i ++ " j: " ++ show j) False = undefined
          | j < 0 = Nothing
          | j == 0 = Just $ replicate lcoins 0
          | i < 0 = Nothing
          | otherwise = vcoins ! (i' + j' * lcoins)
            where i' = fromIntegral i
                  j' = fromIntegral j

        g :: Int -> Maybe [Integer]
        --g n | trace ("n: " ++ show n ++ " " ++ show (toInteger (n `mod` lcoins)) ++ " " ++ show (toInteger $ n `div` lcoins)  ) False = undefined
        g n = f (toInteger (n `mod` lcoins)) $ toInteger $ n `div` lcoins
