module Robot (Robot, initialState, mkRobot, resetName, robotName) where

import Control.Monad.State (StateT, liftIO, get)
import Data.IORef
import Control.Monad
import System.Random

type Robot = IORef String
type RunState = [String]

initialState :: RunState
initialState = error "You need to implement this function"

mkRobot :: StateT RunState IO Robot
mkRobot = do
    xs <- get
    return ""

resetName :: Robot -> StateT RunState IO ()
resetName robot = do
    liftIO $ writeIORef robot ""
    return ()

robotName :: Robot -> IO String
robotName = readIORef

randomName :: IO String
randomName = do
    keys <- replicateM 15 $ randomRIO ('a', 'z')
    return keys

