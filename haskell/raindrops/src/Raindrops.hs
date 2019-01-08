module Raindrops (convert) where

showMessage :: Int -> [(Int, String)] -> String
showMessage _ [] = ""
showMessage n ((divisor, name) : xs) = fname ++ showMessage n xs
    where fname = if n `mod` divisor == 0 then name else ""

convert :: Int -> String
convert n = nmessage
    where message = showMessage n [(3, "Pling"), (5, "Plang"), (7, "Plong")]
          nmessage = if message == "" then show n else message
