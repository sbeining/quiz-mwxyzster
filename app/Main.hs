{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import Data.Question
import Paths
import qualified Graphics.UI.Threepenny as UI
import Graphics.UI.Threepenny.Core

main :: IO ()
main = do
  static <- getStaticPath
  path <- getQuestionsPath
  questions <- fromFilePath path

  startGUI defaultConfig
    { jsStatic = Just static
    } $(setup questions)

setup :: [Question] -> Window -> UI ()
setup questions window = void $ do
  _ <- return window # set UI.title "Quiz Mwxyzster"
  UI.addStyleSheet window "styles.css"

  -- GUI Elements
  number <- UI.input
    # set value "0"
    # set (attr "type") "hidden"
  question <- UI.div
    # set text "Click or press space to start (Press backspace to go back.)"

    -- Events
  on UI.click question $ const $ nextQuestion number question

  body <- getBody window
  on UI.keyup body $ \keycode -> when (keycode == space) $ void $ prevQuestion number question
  on UI.keyup body $ \keycode -> when (keycode == backspace) $ void $ nextQuestion number question

  -- DOM
  getBody window #+
    [ element number
    , element question
    ]

  where
    space :: Int
    space = 8

    backspace :: Int
    backspace = 32

    prevQuestion :: Element -> Element-> UI Element
    prevQuestion number outputElement = do
      nr <- get value number
      let num = (read nr) - 1
      _ <- element outputElement # set text (questionContent $ questions!!(num - 1))
      element number # set value (show num)

    nextQuestion :: Element -> Element-> UI Element
    nextQuestion number outputElement = do
      nr <- get value number
      let num = (read nr) + 1
      _ <- element outputElement # set text (questionContent $ questions!!(num - 1))
      element number # set value (show num)
