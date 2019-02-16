module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

data BST a = Empty | Node a (BST a) (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Empty = Nothing
bstLeft (Node _ left _) = Just left

bstRight :: BST a -> Maybe (BST a)
bstRight Empty = Nothing
bstRight (Node _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Empty = Nothing
bstValue (Node value _ _) = Just value

empty :: BST a
empty = Empty

fromList :: Ord a => [a] -> BST a
fromList [] = Empty
fromList (x:xs) = Node x left right
    where left = fromList $ filter (<= x) xs
          right = fromList $ filter (> x) xs


insert :: Ord a => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node value left right)
  | x <= value = Node value (insert x left) right
  | otherwise = Node value left (insert x right)

singleton :: a -> BST a
singleton x = Node x Empty Empty

toList :: BST a -> [a]
toList Empty = []
toList (Node value left right) = toList left ++ [value] ++ toList right
