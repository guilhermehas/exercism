module Beer (song) where

import Text.Printf

showNumber :: Int -> String
showNumber (-1) = showNumber 99
showNumber 0 = "no more bottles"
showNumber 1 = "1 bottle"
showNumber n = printf "%d bottles" n

firstArg :: Int -> String
firstArg 0 = "No more bottles"
firstArg n = showNumber n

oneOrMany :: Int -> String
oneOrMany 1 = "it"
oneOrMany _ = "one"

zeroOrMany :: Int -> String
zeroOrMany 0 = "Go to the store and buy some more"
zeroOrMany n = printf "Take %s down and pass it around" $ oneOrMany n

sentence :: Int -> String
sentence n = printf ("%s of beer on the wall, %s of beer.\n" ++
    "%s, %s of beer on the wall.\n\n") arg0 arg1 arg2 arg3
        where
            arg0 = firstArg n
            arg1 = showNumber n
            arg2 = zeroOrMany n
            arg3 = showNumber $ n - 1

song :: String
song = init $ concatMap sentence [99,98..0]
