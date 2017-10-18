module Component.FinishComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.SearchComponent exposing (..)
import Component.RadioComponent exposing (..)


displayDrawnCollections : Model -> Html Msg 
displayDrawnCollections model =
    div [ class "display__drawn__collections" ]
        [ h1 [] [ text "Upload and save your drawings!" ]
        , div [] ( List.map displayDrawnImages model.loadedCollectionsWithImages )
        ]

displayDrawnImages : CollectionImages -> Html Msg
displayDrawnImages loadedCollectionsWithImages = 
    div []
        ( List.map drawnImages loadedCollectionsWithImages.images )
        

drawnImages : Image -> Html Msg 
drawnImages image = 
    div [] 
        [ div []
              [ img [ src image.image_url] []
              ]
        , div [] 
              [ Html.form [] [] ]
        ]


tryNewCollections : Model -> Html Msg 
tryNewCollections model =
    div [ class "reference__tool__stop"]
        [ selectionComponent model
        , radioIntervalComponent model
        , radioUpsideDownComponent model 
        , submitComponent
        ]


relevantUserImages : Model -> Html msg
relevantUserImages model =
    div []
        [ ]