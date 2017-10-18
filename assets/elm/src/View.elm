module View exposing (..)

import Html exposing (..)

import Model exposing (..)
import Msg exposing (..)

import Component.ReferenceComponent exposing (..)
import Component.SearchComponent exposing (..)

viewSearch : Model -> Html Msg
viewSearch model =
    div [] 
        [(searchComponent model)
        , p [] [text "there you go"]]
    

viewReference : Model -> Html Msg
viewReference model =
    div []
        [ referenceComponent model ]
