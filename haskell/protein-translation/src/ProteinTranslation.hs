module ProteinTranslation(proteins) where

chunks :: Int -> [a] -> [[a]]
chunks _ [] = []
chunks n xs =
    let (ys, zs) = splitAt n xs
    in  ys : chunks n zs


toAminoacides :: Char -> Maybe Char
toAminoacides ch = 
    case ch of
      'A' -> Just 'A'
      'U' -> Just 'U'
      'G' -> Just 'G'
      'C' -> Just 'C'
      otherwise -> Nothing

listAminoProtein :: [([String], String)]
listAminoProtein = [(["AUG"], "Methionine"), 
    (["UUU", "UUC"], "Phenylalanine"), 
    (["UUA", "UUG"], "Leucine"),
    (["UCU", "UCC", "UCA", "UCG"], "Serine"),
    (["UAU", "UAC"], "Tyrosine"),
    (["UGU", "UGC"], "Cysteine"),
    (["UGG"], "Tryptophan"),
    (["UAA", "UAG", "UGA"], "STOP")]

toProteinFromList :: [([String], String)] -> String -> Maybe String 
toProteinFromList [] _ = Nothing
toProteinFromList ((aminosVet, prot) :xs) aminos
  | aminos `elem` aminosVet = Just prot
  | otherwise = toProteinFromList xs aminos

aminoToProtein :: String -> Maybe String
aminoToProtein = toProteinFromList listAminoProtein

concatMaybe :: Maybe String -> Maybe [String] -> Maybe [String]
concatMaybe Nothing _ = Nothing
concatMaybe _ Nothing = Nothing
concatMaybe (Just "STOP") (Just _) = Just []
concatMaybe (Just s) (Just vet) = Just $ s : vet

proteins :: String -> Maybe [String]
proteins = foldr concatMaybe (Just []) . map aminoToProtein . chunks 3
