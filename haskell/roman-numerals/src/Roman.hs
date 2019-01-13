module Roman (numerals) where

import Data.List
import Data.Char

replace :: Eq a => a -> a -> [a] -> [a]
replace a b = map $ \c -> if c == a then b else c

toAlgorism :: Int -> Char -> Char -> Char -> String
toAlgorism 0 _ _ _ = ""
toAlgorism n one five ten = algs !! (n - 1)
    where algsI = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
          algs :: [String]
          algs = map (replace 'I' one . replace 'V' five . replace 'X' ten) algsI

toIndice :: Integer -> Char -> Int
toIndice ns ch = (n `div` (10 ^ (ord ch - ord 'A'))) `mod` 10
    where n = fromIntegral ns

numerals :: Integer -> Maybe String
numerals n
  | n <= 0 = Nothing
  |otherwise = Just $ concat $ reverse [toAlgorism (toIndice n p) one five ten |
      [one, five, ten, p] <- transpose [listI, listV, tail listI, ['A'..]]]
    where 
        listI = "IXCM_"
        listV = "VLD_"

