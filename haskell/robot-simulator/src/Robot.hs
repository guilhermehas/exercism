module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show, Ord)

data Robot = Robot Bearing (Integer, Integer)

arrayToFunc :: Eq a => [(a,b)] -> a -> b
arrayToFunc [] _ = error "Not function"
arrayToFunc ((x,y):xs) z = if x == z then y else arrayToFunc xs z

bearing :: Robot -> Bearing
bearing (Robot b _) = b

coordinates :: Robot -> (Integer, Integer)
coordinates (Robot _ coords) = coords

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

ordBeard :: [Bearing]
ordBeard = [North, East, South, West]

right :: Bearing -> Bearing
right = arrayToFunc $ zip ordBeard $ tail $ cycle ordBeard

left :: Bearing -> Bearing
left = arrayToFunc $ zip (tail $ cycle ordBeard) ordBeard

advance :: Robot -> Robot
advance (Robot bear (x,y)) = Robot bear (xn,yn)
    where (xn, yn) = case bear of
                       North -> (x,y+1)
                       East -> (x+1,y)
                       South -> (x,y-1)
                       West -> (x-1,y)

instToRobot :: Char -> Robot -> Robot
instToRobot ch robot = 
    case ch of
      'A' -> advance robot
      'R' -> toRobot right
      'L' -> toRobot left
      _ -> error "invalid instruction"
      where
          Robot bear coords = robot
          toRobot f = Robot (f bear) coords


move :: Robot -> String -> Robot
move robot [] = robot
move robot (inst:rinst) = move (instToRobot inst robot) rinst
