module View exposing (..)

import Html exposing (..)

import Model exposing (..)
import Msg exposing (..)

import Component.ReferenceComponent exposing (..)
import Component.SearchComponent exposing (..)

searchView : Model -> Html Msg
view model =
    div [] 
        [(searchComponent model)
        , p [] [text "ylo"]]
    

referenceView : Model -> Html Msg
view model =
    div []
        [ referenceComponent model ]
