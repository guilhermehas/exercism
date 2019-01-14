module Clock (addDelta, fromHourMin, toString) where

data Clock = Clock Int Int deriving (Eq)

fromHourMin :: Int -> Int -> Clock
fromHourMin hour minute = Clock ((hour + div minute 60) `mod` 24) (minute `mod` 60)

show' :: Int -> String
show' n = replicate (2 - length r) '0' ++ r
    where r = show n

toString :: Clock -> String
toString (Clock hour min') = show' hour ++ ":" ++ show' min'

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min'' (Clock hour' min') = fromHourMin (hour + hour') (min'+min'')
