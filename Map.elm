port module Map exposing (main)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toFloat)

type alias Position = 
  { lat : Float
  , lng : Float
  }

type alias Model = 
  {
    position : Position
  , latInput : Float
  , lngInput : Float 
  }

type Msg
  = NewPosition Position
  | ChangePosition Position
  | LatInput String
  | LngInput String 
  | SubmitPosition 

port createMarker : Position -> Cmd msg

model : Model
model = 
  {
    position = Position 0.0 0.0
  , latInput = 0
  , lngInput = 0
  }

view : Model -> Html Msg
view model = div [] 
  [
    div [] [text <| toString model.position.lat]
  , div [] [text <| toString model.position.lng]
  , input [onInput LatInput, value <| toString model.latInput] []
  , input [onInput LngInput, value <| toString model.lngInput] []
  , button [onClick SubmitPosition] [text "Go!"]
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    NewPosition pos ->
      {model | position = pos } ! []

    ChangePosition pos ->
      model ! []

    LatInput val ->
      let 
        lat = String.toFloat val
      in 
       case lat of
        Ok float -> 
          { model | latInput = float } ! []
        Err err ->
          model ! [] 
      
    LngInput val ->
      let 
        lng = String.toFloat val
      in 
       case lng of
        Ok float -> 
          { model | lngInput = float } ! []
        Err err ->
          model ! []

    SubmitPosition ->
      model ! [createMarker <| Position model.latInput model.lngInput] 
 

-- subscriptions

port latLng : (Position -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model = 
  latLng NewPosition
  
main : Program Never
main = 
  App.program 
    {
      init = (model, Cmd.none)
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

