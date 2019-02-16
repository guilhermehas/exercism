module OCR (convert) where

import Data.Char
import Data.List
import Data.List.Split
import Data.Maybe

numbersString :: [String]
numbersString = 
   [ " _     _  _     _  _  _  _  _ "
   , "| |  | _| _||_||_ |_   ||_||_|"
   , "|_|  ||_  _|  | _||_|  ||_| _|"
   , "                              "]

toGroup :: [String] -> [[[String]]]
toGroup = map (transpose . map (chunksOf 3)) . chunksOf 4

convert :: String -> String
convert =  intercalate ","  . map (map (fromMaybe '?' . fmap intToDigit . (flip elemIndex) numbers)) . toGroup . lines
    where numbers = head $ toGroup numbersString
