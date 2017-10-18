module MainReferenceTool exposing (..)

import Html exposing (..)
import Model exposing (..)
import Msg exposing (..)
import View exposing (viewReference)
import Update exposing (..)

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

    , applicationStatus = Stop
    , popupStatus = Resume
    , imageStatus = Normal

    , radioInterval = I30
    , radioUpsideDown = NoUpsideDown
    , radioDistraction = NoMinimalDistraction

    , loadedCollectionsWithImages = []
    
    , error = "" 
    } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

