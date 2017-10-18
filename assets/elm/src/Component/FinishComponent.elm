module Component.FinishComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import Update exposing (..)

displayDrawnImages : Model -> Html msg
displayDrawnImages = 
    div [] []