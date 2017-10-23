module Component.FinishComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.SearchComponent exposing (..)
import Component.RadioComponent exposing (..)


displayDrawnCollections : CollectionImagesList -> Html Msg 
displayDrawnCollections loadedCollectionImagesList =
    div [ class "display__drawn__collections" ]
        [ h1 [] [ text "Upload and save your drawings!" ]
        , div [] ( List.map displayDrawnImages loadedCollectionImagesList )        
        ]

displayDrawnImages : CollectionImages -> Html Msg
displayDrawnImages collectionImages =
    div []
        ( List.map drawnImages collectionImages.images )
        

drawnImages : Image -> Html Msg 
drawnImages image = 
    div [] 
        [ div []
              [ img [ src image.image_url] []
              ]
        , div [] 
              [ Html.form [] [] ]
        ]


relevantUserImages : Model -> Html Msg
relevantUserImages model =
    div []
        []