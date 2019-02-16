module Queens (boardString, canAttack) where

import Data.List

modList :: Int -> a -> [a] -> [a]
modList n newElement xs = take n xs ++ [newElement] ++ drop (n + 1) xs

modifyBoard :: Char -> Maybe (Int, Int) -> [String] -> [String]
modifyBoard _ Nothing board = board
modifyBoard ch (Just (posx, posy)) board = modList posx (modList posy ch $ board !! posy) board

addAtEnd :: a -> [a] -> [a]
addAtEnd ch xs = reverse $ ch : reverse xs

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = 
      addAtEnd '\n'
    $ intercalate ['\n'] 
    $ map (intercalate " " . map (\x -> [x]))
    $ modifyBoard 'W' white 
    $ modifyBoard 'B' black 
    $ replicate 8 
    $ replicate 8 '_'

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (x,y) (px,py) = abs (x-px) == abs (y-py) || x == px || y == py
