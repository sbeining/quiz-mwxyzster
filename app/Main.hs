{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import Data.Question
import Paths
import qualified Graphics.UI.Threepenny as UI
import Graphics.UI.Threepenny.Core

main :: IO ()
main = do
  path <- getQuestionsPath
  questions <- fromFilePath path

  startGUI defaultConfig (setup questions)

setup :: [Question] -> Window -> UI ()
setup questions window = void $ do
  _ <- return window # set UI.title "Quiz Mwxyzster"

  -- GUI Elements
  number <- UI.input
    # set value "0"
    # set (attr "type") "hidden"
  question <- UI.div
    # set text "Click to start"

    -- Events
  on UI.click question $ const $ do
    nr <- get value number
    let num = read nr
    _ <- element question # set text (questionContent $ questions!!num)
    element number # set value (show $ num + 1)

  -- DOM
  getBody window #+
    [ element number
    , element question
    ]
