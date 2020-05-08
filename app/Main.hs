{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Question
import System.Directory
import System.FilePath

main :: IO ()
main = do
  questions <- fromFilePath "questions"
  print $ questions
