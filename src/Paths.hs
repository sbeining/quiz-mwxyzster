module Paths
  ( getQuestionsPath
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
