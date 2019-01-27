module Brackets (arePaired) where

import Data.Maybe
import Data.List

data Bracket = Start Char | End Char deriving (Show)

makeBracket :: Char -> Maybe Bracket
makeBracket ch
  | ch `elem` "({[" = Just $ Start ch
  | ch `elem` ")}]" = Just $ End $ opposite ch
  | otherwise = Nothing

addElementToList :: Maybe String -> Bracket -> Maybe String
addElementToList Nothing _ = Nothing
addElementToList (Just xs) (Start y) = Just $ y:xs
addElementToList (Just []) (End _) = Nothing
addElementToList (Just (x:xs)) (End y)
  | x == y = Just xs
  | otherwise = Nothing

second :: [a] -> a
second (_:x:_) = x

opposite :: Char -> Char
opposite ch = head $ fromJust $ find ((==ch) . second) pairs
    where pairs = ["()","[]", "{}"]


toBool :: Maybe String -> Bool
toBool (Just "") = True
toBool _ = False

arePaired :: String -> Bool
arePaired = toBool . foldl addElementToList (Just "") . mapMaybe makeBracket
