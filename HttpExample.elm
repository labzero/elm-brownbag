-- npm install -g json-server
-- /usr/local/bin/json-server http://jsonplaceholder.typicode.com/db

module HttpExample exposing (..)

import Html.App as App
import Html exposing (..)
import Http
import Task exposing (Task)
import Json.Decode exposing (Decoder, (:=), object3, string, int)

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
  | LoadPostsFailure Http.Error
  | UpdateNewPostTitle String
  | UpdateNewPostBody String
  | SubmitNewPost


initialModel : Model
initialModel = 
  { posts = []
  , newPostTitle = ""
  , newPostBody = ""
  }

view : Model -> Html Msg
view model = 
  div [] 
    (List.map postView model.posts) 

postView : Post -> Html Msg
postView post =
  div [] 
  [    
    h4 [] [text post.title]  
  , p [] [text post.body] 
  ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    LoadPosts posts -> 
      {model | posts = posts} ! []

    LoadPostsFailure err ->
      model ! []

    UpdateNewPostTitle str ->
      model ! []
    
    UpdateNewPostBody str ->
      model ! []

    SubmitNewPost ->
      model ! []

-- Tasks
getPostsTask : Task Http.Error (List Post)
getPostsTask =
    Http.get postListDecoder "http://localhost:3000/posts"


-- Cmds
getPosts : Cmd Msg
getPosts = 
  getPostsTask |> Task.perform LoadPostsFailure LoadPosts  

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
    
