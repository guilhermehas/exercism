module Allergies (Allergen(..), allergies, isAllergicTo) where

data Allergen = Eggs
              | Peanuts
              | Shellfish
              | Strawberries
              | Tomatoes
              | Chocolate
              | Pollen
              | Cats
              deriving (Eq, Show, Enum)

toBin :: Int -> [Bool]
toBin 0 = []
toBin n = (n `mod` 2 == 1) : toBin (n `div` 2)

filterGoods :: [Bool] -> [a] -> [a]
filterGoods _ [] = []
filterGoods [] _ = []
filterGoods (x:xs) (y:ys) = if x then y : zs else zs
    where zs = filterGoods xs ys

allergies :: Int -> [Allergen]
allergies score = filterGoods (toBin score) allergens
    where allergens = [Eggs .. Cats]


isAllergicTo :: Allergen -> Int -> Bool
isAllergicTo allergen = elem allergen . allergies
