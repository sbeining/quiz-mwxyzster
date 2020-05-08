module Paths
  ( getQuestionsPath
  , getStaticPath
  )
where

import System.Directory (doesDirectoryExist, makeAbsolute)
import System.Environment.Executable (splitExecutablePath)
import System.FilePath ((</>))

getQuestionsPath :: IO FilePath
getQuestionsPath = do
  (execPath, _) <- splitExecutablePath
  exists <- doesDirectoryExist (execPath </> "questions")
  return $ if exists
      then execPath </> "questions"
      else "questions"

getStaticPath :: IO FilePath
getStaticPath = do
  (execPath, _) <- splitExecutablePath
  exists <- doesDirectoryExist (execPath </> "static")
  if exists
    then return $ execPath </> "static"
    else makeAbsolute "static"
