module Phone (number) where

import Data.Char

number2 :: String -> Maybe String
number2 xs = if cond then Just nxs else Nothing
    where nxs = if length xs == 11 then tail xs else xs
          cond = all (flip elem $ ['2'..'9']) [nxs !! 0, nxs !! 3]


number :: String -> Maybe String
number xs = if cond then number2 noPont else Nothing
    where noPont = filter (not . (flip elem) " ()-+.") xs
          size = length noPont
          cond = all isDigit noPont && (size == 10 || size == 11 && head noPont == '1')
