-- # for placeholder API backend
-- npm install -g json-server
-- /usr/local/bin/json-server http://jsonplaceholder.typicode.com/db

-- # to run with elm-live
-- npm install -g elm-live
-- elm-live --port=9000 HttpExample.elm --output posts.js

module HttpExample exposing (..)

import Html.App as App
import Html exposing (..)
import Http
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (Task)
import Json.Decode exposing (Decoder, (:=), object3, string, int)
import Json.Encode exposing (encode)

type alias Post = 
  { id : Int
  , title : String
  , body : String
  }

type alias Model = 
  {
    posts : List Post
  , newPostTitle : String
  , newPostBody : String
  }

type Msg 
  = LoadPosts (List Post)
  | ApiFailure Http.Error
  | UpdateNewPostTitle String
  | UpdateNewPostBody String
  | SubmitNewPost
  | NewPost Post


initialModel : Model
initialModel = 
  { posts = []
  , newPostTitle = ""
  , newPostBody = ""
  }

view : Model -> Html Msg
view model = 
  body [style [("margin", "50px")]] <| 
    (List.map postView model.posts) ++
    [postForm model] 

postView : Post -> Html Msg
postView post =
  div [] 
  [    
    h4 [] [text post.title]  
  , p [] [text post.body] 
  ]

postForm : Model -> Html Msg
postForm model = 
  div [] 
  [
    label [for "postTitle"] [text "Title"]
  , input 
    [
      id "postTitle"
    , value model.newPostTitle
    , style [("display", "block")]
    , onInput UpdateNewPostTitle
    ] []
  , label [for "postBody"] [text "Body"]
  , textarea 
    [
      id "postBody"
    , value model.newPostBody
    , onInput UpdateNewPostBody
    , style [("display", "block")]
    ] []
  , button [onClick SubmitNewPost] [text "Create New Post"]
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    LoadPosts posts -> 
      {model | posts = posts} ! []

    ApiFailure err ->
      model ! []

    UpdateNewPostTitle str ->
      { model | newPostTitle = str } ! []
    
    UpdateNewPostBody str ->
      { model | newPostBody = str } ! []

    SubmitNewPost ->
      model ! [submitPost model]

    NewPost post ->
      { model | posts = model.posts ++ [post], newPostTitle = "", newPostBody = "" } ! []

-- Tasks
getPostsTask : Task Http.Error (List Post)
getPostsTask =
    Http.get postListDecoder "http://localhost:3000/posts"

submitPostTask : Model -> Task Http.Error Post
submitPostTask model = 
    let
        encoder = Json.Encode.object
          [
            ("userId", Json.Encode.int 1)
          , ("title", Json.Encode.string model.newPostTitle)
          , ("body", Json.Encode.string model.newPostBody) 
          ]
        body = encode 0 encoder |> Http.string
        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , body = body
            , url = "http://localhost:3000/posts"
            }
    in
        Http.send Http.defaultSettings config |> Http.fromJson postDecoder      


-- Cmds
getPosts : Cmd Msg
getPosts = 
  getPostsTask |> Task.perform ApiFailure LoadPosts

submitPost : Model -> Cmd Msg
submitPost model = 
  submitPostTask model |> Task.perform ApiFailure NewPost
 

-- Decoders
postDecoder : Decoder Post
postDecoder = 
  object3 Post
    ("id" := int)
    ("title" := string)
    ("body" := string)

postListDecoder : Decoder (List Post)
postListDecoder =
  Json.Decode.list postDecoder


main = App.program
  {
    init = (initialModel, getPosts)
  , update = update
  , view = view
  , subscriptions = \_ -> Sub.none 
  }
    
