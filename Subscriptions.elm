module Subscriptions exposing (main)

import Time exposing (Time)
import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model = 
  {
    lastTick : Time
  }

type Msg 
  = Tick Time

initialModel : Model
initialModel = 
  {
    lastTick = 0.0
  }

update : Msg -> Model -> (Model, Cmd msg)
update msg model = 
  case msg of
    Tick t ->
      { model | lastTick = t } ! []


view : Model -> Html msg
view model = body [style [("margin", "100px")]]
        [ 
          div [] [text <| toString model.lastTick] 
        ]

subscriptions : Model -> Sub Msg
subscriptions model =
      Time.every Time.second Tick
  
main : Program Never
main = App.program
  {
    init = initialModel ! []
  , update = update
  , view = view
  , subscriptions = subscriptions
  }