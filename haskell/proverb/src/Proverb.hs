module Proverb(recite) where

import Data.List

sentence :: (String, String) -> String
sentence (f, s) = "For want of a " ++ f ++ " the " ++ s ++ " was lost."

finalSentence :: String -> String
finalSentence s = "And all for the want of a " ++ s ++ "."

recite :: [String] -> String
recite [] = ""
recite xs =  intercalate "\n" $ map sentence (zip xs (tail xs)) ++ [finalSentence x]
    where x = head xs
