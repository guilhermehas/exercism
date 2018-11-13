{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_rna_transcription (
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
version = Version [1,3,0,8] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/bin"
libdir     = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3/rna-transcription-1.3.0.8-75HKYJ0LbPVFtn26ItffuO-test"
dynlibdir  = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/lib/x86_64-linux-ghc-8.4.3"
datadir    = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/share/x86_64-linux-ghc-8.4.3/rna-transcription-1.3.0.8"
libexecdir = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/libexec/x86_64-linux-ghc-8.4.3/rna-transcription-1.3.0.8"
sysconfdir = "/home/guilherme/exercism/haskell/rna-transcription/.stack-work/install/x86_64-linux-nopie/lts-12.4/8.4.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "rna_transcription_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "rna_transcription_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "rna_transcription_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "rna_transcription_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "rna_transcription_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "rna_transcription_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
