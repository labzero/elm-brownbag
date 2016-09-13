module Main2 exposing (main)

import Html.App as App
import Html exposing (..)
import Html.Events exposing (..)

type alias Model = 
  {
    counter : Int
  }

model : Model
model = 
  {
    counter = 0
  }

type Msg 
  = Increment

view : Model -> Html Msg
view model = div [] 
  [
    div [] [text (toString model.counter)]
  , button [onClick Increment] [text "Click Me"]
  ]

update : Msg -> Model -> Model
update msg model = 
  case msg of
    Increment -> {model | counter = model.counter + 1}

main = 
  App.beginnerProgram { model = model, view = view, update = update}