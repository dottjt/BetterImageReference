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
    -- Search Functions
    { searchedCollections = []
    , selectedCollections = []

    , searchInput = ""
    , popularQueries = ["popular", "human figure", "face"]

    -- Application Status
    , applicationStatus = Initial
    , popupStatus = Resume
    , imageStatus = Normal

    -- Selection Criteria
    , radioIntervalType = Second
    , radioIntervalTiming = S30
    , radioIntervalCustomInput = 0

    , radioUpsideDown = NoUpsideDown
    , radioDistraction = NoMinimalDistraction

    -- Popup Component
    , loadedImageAssocList = []
    , currentImage = { name = ""
                     , image_url = ""
                     , id = ""
                     , display_name = ""
                     , times_drawn = 0
                     , image_comments = []
                     , image_scribbles = []
                     , image_tags = []
                     , image_drawings = []
    }

    , imageTime = 0
    
    , error = "" 
    } ! [ initialFetchQuery ]




subscriptions : Model -> Sub Msg
subscriptions model =
      Time.every second Tick



