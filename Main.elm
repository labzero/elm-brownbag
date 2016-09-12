module Main exposing (..)

import Html exposing (..)

aString = "I am a String"

aNumber = 12345

aList = [1, 2, 3, 4, 5]

anotherList = ["foo", "bar", "baz"]

aTuple = (12, "foo")

func = \x -> x + 1

main =
  div []
    [
      text aString
    , text (toString aNumber)
    , text (toString aList)
    , text (toString anotherList)
    , text (toString aTuple)
    , text (toString (func aNumber))
    ]
