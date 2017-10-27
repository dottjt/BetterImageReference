module Component.FinishComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.SearchComponent exposing (..)
import Component.RadioComponent exposing (..)


displayDrawnCollections : ImageAssocList -> Html Msg 
displayDrawnCollections loadedImageAssocList =
    div [ class "display__drawn__collections" ]
        [ h1 [] [ text "Upload and save your drawings!" ]
        , div [] ( List.map displayImageAssoc loadedImageAssocList )        
        ]

displayImageAssoc : ImageAssoc -> Html Msg
displayImageAssoc imageAssoc =
    div []
        ( List.map displayDrawnImages imageAssoc.image_drawings )


displayDrawnImages : ImageDrawing -> Html Msg
displayDrawnImages imageAssoc =
    div [] 
        [ div []
              [ img [ src imageAssoc.name ] []
              ]
        , div [] 
              [ Html.form [] [] ]
        ]
