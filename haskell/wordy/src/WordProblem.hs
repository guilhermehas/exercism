module WordProblem (answer) where

import Debug.Trace
import Control.Monad
import Control.Applicative
import Data.Maybe
import Prelude hiding (init, last, tail, head, (!!))
import Data.List.Safe hiding (foldl1)
import Data.List.Split
import Text.Read

data Operator = Plus | Sub | Mult | Div deriving (Show, Eq)
data Token = Number' Integer | Operator Operator deriving (Show, Eq)

parseOp :: String -> Maybe Operator
parseOp s =
    case s of
      "plus" -> Just Plus
      "minus" -> Just Sub
      "multiplied" -> Just Mult
      "divided" -> Just Div
      _ -> Nothing

parseNum :: String -> Maybe Integer
parseNum = readMaybe

parseWord :: String -> Maybe Token
parseWord s = (Number' <$> parseNum s) <|> (Operator <$> parseOp s)

allowedWords :: String -> Bool
allowedWords "by" = True
allowedWords s = isJust $ parseWord s

correctSentence :: [Token] -> Bool
correctSentence [] = False
correctSentence [Operator _] = False
correctSentence [Number' _] = True
correctSentence (Number' _ : Operator _ : xs) = correctSentence xs
correctSentence _ = False

operatorToFunction :: Operator -> Integer -> Integer -> Integer
operatorToFunction Plus = (+)
operatorToFunction Sub = (-)
operatorToFunction Mult = (*)
operatorToFunction Div = div

eliminatePure :: [Token] -> Integer
eliminatePure (Number' firstNumber:xs) = 
                       foldl fOpNumber firstNumber
                    $  chunksOf 2 xs
    where fOpNumber numb [Operator op, Number' n] = operatorToFunction op numb n

merge :: [a] -> [a] -> [a]
merge [] ys = ys
merge (x:xs) ys = x:merge ys xs

isPlusSub :: Token -> Bool
isPlusSub (Operator Plus) = True
isPlusSub (Operator Sub) = True
isPlusSub _ = False

eliminateAddSub :: [Token] -> Integer
eliminateAddSub xs = eliminatePure $ merge numbers plusSub
    where numbers = map (Number' . eliminatePure . traceShowId) . splitWhen isPlusSub $ traceShowId xs
          plusSub = filter isPlusSub xs

parseSentence :: String -> Maybe [Token]
parseSentence s = do
    guard $ last s == Just '?'
    swords <- words <$> init s
    guard $ swords !! (0 :: Int) == Just "What"
    guard $ swords !! (1 :: Int) == Just "is"
    swords' <- tail =<< tail swords
    guard $ all allowedWords swords'
    tokenSentence <- return $ map fromJust $ filter isJust $ map parseWord swords'
    guard $ correctSentence tokenSentence
    return tokenSentence

answer :: String -> Maybe Integer
answer problem = eliminatePure <$> parseSentence problem
