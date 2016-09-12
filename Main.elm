module Main exposing (..)

import Html exposing (..)

aString : String
aString = "I am a String"

aNumber : Int
aNumber = 12345

aList : List Int
aList = [1, 2, 3, 4, 5]

anotherList : List String
anotherList = ["foo", "bar", "baz"]

aTuple : (Int, String)
aTuple = (12, "foo")

myFunc : Int -> Int
myFunc = \x -> x + 1

sameFunc : Int -> Int
sameFunc x = x + 1

pointFreeFunc : Int -> Int
pointFreeFunc = (+) 1

type alias Person = 
  {
    name : String
  , address : String
  }

-- myRecord : { name: String, address: String} -- boo!
myRecord : Person  
myRecord = 
  {
    name = "John Doe"
  , address = "123 Main St."
  }

item : String -> Html a
item x = 
  li [] [text x]

main : Html a
main =
  ul []
    [
      item aString
    , item (toString aNumber)
    , item (toString aList)
    , item (toString anotherList)
    , item (toString aTuple)
    , item (toString (myFunc aNumber))
    , item (toString myRecord)    
    ]
