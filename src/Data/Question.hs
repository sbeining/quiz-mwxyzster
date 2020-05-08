module Data.Question
  ( Question(..)
  , fromFilePath
  )
where

import Control.Monad.Extra
import System.Directory

data Question = Question { questionContent :: String
                         } deriving Show

fromFilePath :: FilePath -> IO [Question]
fromFilePath path = do
  files <- listDirectory path
  setCurrentDirectory path

  concatMapM fromFile files

fromFile :: FilePath -> IO [Question]
fromFile path = do
  contentOfFile <- readFile path
  let linesOfFile = lines contentOfFile

  return $ Question <$> linesOfFile
