{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Question
import System.Directory
import System.Environment.Executable
import System.FilePath

main :: IO ()
main = do
  -- search in directory of the executable first and then in the current directory
  (execPath, _) <- splitExecutablePath
  exists <- doesDirectoryExist (execPath </> "questions")
  let path = if exists
      then execPath </> "questions"
      else "questions"

  questions <- fromFilePath path
  print $ questions
