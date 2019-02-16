{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_spiral_matrix (
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
version = Version [1,1,0,3] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/bin"
libdir     = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3/spiral-matrix-1.1.0.3-ESVS2zUN6hx8LiXH2Xluz5"
dynlibdir  = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3"
datadir    = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/share/x86_64-linux-ghc-8.4.3/spiral-matrix-1.1.0.3"
libexecdir = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/libexec/x86_64-linux-ghc-8.4.3/spiral-matrix-1.1.0.3"
sysconfdir = "/home/guilherme/exercism/haskell/spiral-matrix/.stack-work/install/x86_64-linux/lts-12.4/8.4.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "spiral_matrix_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "spiral_matrix_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "spiral_matrix_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "spiral_matrix_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "spiral_matrix_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "spiral_matrix_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
