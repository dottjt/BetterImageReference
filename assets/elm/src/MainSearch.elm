module MainSearch exposing (..)

import Html exposing (..)
import Model exposing (..)
import Msg exposing (..)
import View exposing (..)
import Update exposing (..)
import Command exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , view = viewSearch
        , update = update
        , subscriptions = subscriptions
        }

initialModel : ( Model, Cmd Msg )
initialModel =
    { searchedCollections = []
    , selectedCollections = []
    , searchInput = ""

    , applicationStatus = Stop
    , popupStatus = Resume
    , imageStatus = Normal

    , radioInterval = I30
    , radioUpsideDown = NoUpsideDown
    , radioDistraction = NoMinimalDistraction

    , loadedCollectionsWithImages = []
    
    , error = "" 
    } ! [initialFetchQuery]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

