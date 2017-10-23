module MainReferenceTool exposing (..)

import Html exposing (..)
import Model exposing (..)
import Msg exposing (..)
import View exposing (viewReference)
import Command exposing (..)
import Update exposing (..)
import Time exposing (Time, second)

main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , view = viewReference
        , update = update
        , subscriptions = subscriptions
        }

initialModel : ( Model, Cmd Msg )
initialModel =
    { searchedCollections = []
    , selectedCollections = []
    , searchInput = ""
    , popularQueries = ["popular", "human figure", "face"]

    , applicationStatus = Stop
    , popupStatus = Resume
    , imageStatus = Normal
    
    , imageTime = 0
    , imagerTimerBarProgress = 0

    , radioIntervalType = Second
    , radioIntervalTiming = S30
    
    , radioIntervalCustomInput = 0
    , radioUpsideDown = NoUpsideDown
    , radioDistraction = NoMinimalDistraction

    , loadedCollectionImagesList = []
    
    , error = "" 
    } ! [initialFetchQuery]




subscriptions : Model -> Sub Msg
subscriptions model =
      Time.every second ImageTimer



