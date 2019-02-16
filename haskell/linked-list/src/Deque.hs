module Deque (Deque, mkDeque, pop, push, shift, unshift) where

import Data.IORef

data DequeP a = Empty | DequeP a (DequeP a) (DequeP a)
type Deque a = IORef (DequeP a)

mkDeque :: IO (Deque a)
mkDeque = do 
    ref <- newIORef Empty
    return ref

shifq :: DequeP a -> (DequeP a, Maybe a)
shifq Empty = (Empty, Nothing)
shifq (DequeP v Empty right) = (right, Just v)
shifq (DequeP v left right) = (DequeP v dleft right, v')
    where (dleft, v') = shifq left

unshifq :: DequeP a -> a -> DequeP a
unshifq Empty v = DequeP v Empty Empty
unshifq (DequeP v left right) v' = DequeP v (unshifq left v') right

popq :: DequeP a -> (DequeP a, Maybe a)
popq queue = 
    case queue of
        Empty -> (Empty, Nothing)
        (DequeP v left Empty) -> (left, Just v)
        (DequeP v left right) -> (DequeP v left dright, v')
            where (dright, v') = popq right

pushq :: DequeP a -> a -> DequeP a
pushq Empty v = DequeP v Empty Empty
pushq (DequeP v left right) v' = DequeP v left $ pushq right v'

unshift :: Deque a -> a -> IO ()
unshift deque v = do
    modifyIORef deque (flip unshifq v)

shift :: Deque a -> IO (Maybe a)
shift deque = do
    deque' <- readIORef deque
    (deque'', v) <- let r = shifq deque' in return r
    writeIORef deque deque''
    return v

pop :: Deque a -> IO (Maybe a)
pop deque = do
    deque' <- readIORef deque
    (deque'', v) <- let r = popq deque' in return r
    writeIORef deque deque''
    return v

push :: Deque a -> a -> IO ()
push deque v = do
    modifyIORef deque (flip pushq v)
