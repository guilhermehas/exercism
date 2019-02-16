{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_bank_account (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,3] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/bin"
libdir     = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3/bank-account-0.1.0.3-L69UapFXA7D75sNgBS0A0c"
dynlibdir  = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3"
datadir    = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/share/x86_64-linux-ghc-8.4.3/bank-account-0.1.0.3"
libexecdir = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/libexec/x86_64-linux-ghc-8.4.3/bank-account-0.1.0.3"
sysconfdir = "/home/guilherme/exercism/haskell/bank-account/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "bank_account_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "bank_account_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "bank_account_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "bank_account_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "bank_account_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "bank_account_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
