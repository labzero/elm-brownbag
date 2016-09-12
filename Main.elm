module Main exposing (..)

import Html exposing (..)

aString = "I am a String"

aNumber = 12345

aList = [1, 2, 3, 4, 5]

anotherList = ["foo", "bar", "baz"]

aTuple = (12, "foo")

myFunc = \x -> x + 1

item x = 
  li [] [text x]

main =
  ul []
    [
      item aString
    , item (toString aNumber)
    , item (toString aList)
    , item (toString anotherList)
    , item (toString aTuple)
    , item (toString (myFunc aNumber))
    ]
