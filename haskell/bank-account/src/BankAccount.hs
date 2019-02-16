module BankAccount
    ( BankAccount
    , closeAccount
    , getBalance
    , incrementBalance
    , openAccount
    ) where

import Data.IORef

data Bank = Bank Integer
type BankAccount = IORef (Maybe Bank)

zeroAccount :: Maybe Bank -> Maybe Bank
zeroAccount _ = Nothing

closeAccount :: BankAccount -> IO ()
closeAccount account = do
    modifyIORef account zeroAccount

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance account = do
    mbank <- readIORef account
    case mbank of
      (Just (Bank balance)) -> return $ Just balance
      Nothing -> return Nothing

incAccount :: Integer -> Maybe Bank -> Maybe Bank
incAccount _ Nothing = Nothing
incAccount amount (Just (Bank s)) = Just $ Bank $ s + amount

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance account amount = do
    modifyIORef account (incAccount amount)
    getBalance account
    

openAccount :: IO BankAccount
openAccount = do
    bank <- newIORef (Just $ Bank 0)
    return bank
