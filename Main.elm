module Main2 exposing (main)

import Html.App as App
import Html exposing (..)
import Html.Events exposing (..)

type alias Model = 
  {
    counter : Int
  , fieldContents : String
  }

model : Model
model = 
  {
    counter = 0
  , fieldContents = ""
  }

type Msg 
  = Increment
  | Decrement
  | UpdateFieldContents String

view : Model -> Html Msg
view model = div [] 
  [
    div [] [text (toString model.counter)]
  , button [onClick Increment] [text "+"]
  , button [onClick Decrement] [text "-"]
  , div [] 
    [
      input [onInput UpdateFieldContents] [text model.fieldContents]
    , div [] [text model.fieldContents]
    ]
  ]

update : Msg -> Model -> Model
update msg model = 
  case msg of
    Increment -> {model | counter = model.counter + 1}
    Decrement -> {model | counter = model.counter - 1}
    UpdateFieldContents str ->
      {model | fieldContents = str}
    
main = 
  App.beginnerProgram { model = model, view = view, update = update}