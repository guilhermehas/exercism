module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Cons a (LinkedList a) | Empty deriving (Eq, Show)

datum :: LinkedList a -> a
datum Empty = error "List must be empty"
datum (Cons x _) = x

fromList :: [a] -> LinkedList a
fromList [] = Empty
fromList (x:xs) = Cons x $ fromList xs

isNil :: LinkedList a -> Bool
isNil Empty = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

next :: LinkedList a -> LinkedList a
next Empty = error "List should have at least one element"
next (Cons _ xs) = xs

nil :: LinkedList a
nil = Empty

reverseLinkedListAcc :: LinkedList a -> LinkedList a -> LinkedList a
reverseLinkedListAcc acc Empty = acc
reverseLinkedListAcc acc (Cons x xs) = reverseLinkedListAcc (Cons x acc) xs

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = reverseLinkedListAcc Empty

toList :: LinkedList a -> [a]
toList Empty = []
toList (Cons x xs) = x : toList xs
