module Component.RadioComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import Update exposing (..)



radioIntervalComponent : Model -> Html Msg 
radioIntervalComponent model =
    fieldset []
        [ radio "30" (model.radioInterval == I30) (SelectIntervalTiming I30)
        , radio "45" (model.radioInterval == I45) (SelectIntervalTiming I45)
        , radio "60" (model.radioInterval == I60) (SelectIntervalTiming I60)
        , radio "90" (model.radioInterval == I90) (SelectIntervalTiming I90)
        , radio "120" (model.radioInterval == I120) (SelectIntervalTiming I120)
        , radio "Custom" (model.radioInterval == Custom) (SelectIntervalTiming Custom)
        ]


radioUpsideDownComponent : Model -> Html Msg 
radioUpsideDownComponent model =
    fieldset []
        [ radio "Yes" (model.radioUpsideDown == YesUpsideDown) (SelectUpsideDown YesUpsideDown)
        , radio "No" (model.radioUpsideDown == NoUpsideDown) (SelectUpsideDown NoUpsideDown)
        ]


radio : String -> Bool -> msg -> Html msg
radio value isChecked msg =
  label
    [ style [("padding", "20px")]
    ]
    [ input [ type_ "radio", name "font-size", onClick msg, checked isChecked ] []
    , text value                                -- this might need to be onInput?
    ]
