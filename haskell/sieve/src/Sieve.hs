module Sieve (primesUpTo) where

-- You should not use any of the division operations when implementing
-- the sieve of Eratosthenes.
import Prelude hiding (div, mod, divMod, rem, quotRem, quot, replicate, toList, (/))
import qualified Prelude

import Data.Vector hiding (map, zip, filter)
import qualified Data.Vector as Vector

removePrimes :: Integer -> Integer -> Vector Bool -> Vector Bool
removePrimes prime bound vec = vec // (zip notPrimes  (repeat False))
    where  notPrimes = map fromIntegral [2*prime,3*prime..bound]

notPrimes :: Integer -> Integer -> Vector Bool
notPrimes 1 bound = replicate (fromIntegral bound + 1) True // [(0,False), (1, False)]
notPrimes n bound = removePrimes n bound $ notPrimes (n-1) bound

primesUpTo :: Integer -> [Integer]
primesUpTo n = (map (fromIntegral . fst) . filter snd . toList . indexed . notPrimes n) n
