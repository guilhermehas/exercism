module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (insert, Map, empty, findWithDefault, fromList)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

toNucleotide :: Char -> Maybe Nucleotide
toNucleotide x
  | x == 'A' = Just A
  | x == 'C' = Just C
  | x == 'G' = Just G
  | x == 'T' = Just T
  | otherwise = Nothing

count ::  [Maybe Nucleotide] -> (Map Nucleotide Int)
count [] = fromList [(A,0), (C,0), (G,0), (T,0)]
count (y:xs) = 
    case y of
      Nothing    -> count xs
      Just x ->
          let rec_map = count xs
              qt = findWithDefault 0 x rec_map
           in Data.Map.insert x (qt+1) rec_map


nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = 
    let nucleotides = map toNucleotide xs
    in 
        if Nothing `elem` nucleotides
           then Left xs
           else (Right . count) nucleotides

