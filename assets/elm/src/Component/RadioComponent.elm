module Component.RadioComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)



radioIntervalComponent : Model -> Html Msg 
radioIntervalComponent model =
    div [] [ radioIntervalTypeComponent model
           , radioIntervalSecondsOrMinutesComponent model 
           ]

-- SECOND/MINUTE RADIO COMPONENTS


radioIntervalSecondsOrMinutesComponent : Model -> Html Msg
radioIntervalSecondsOrMinutesComponent model =
    case model.radioIntervalType of
        Second ->
            radioIntervalSecondsComponent model
        Minute ->
            radioIntervalMinutesComponent model


radioIntervalSecondsComponent : Model -> Html Msg 
radioIntervalSecondsComponent model =
    Html.form [ class "radio__interval__timing__container" ]
        [ radioComponent model "30" S30
        , radioComponent model "45" S45
        , radioComponent model "60" S60
        , radioComponent model "90" S90
        , radioComponent model "120" S120
        , radioComponent model "Custom" Custom
        , customInputComponent model
        ]


radioIntervalMinutesComponent : Model -> Html Msg
radioIntervalMinutesComponent model =
    Html.form [ class "radio__interval__timing__container" ]
        [ radioComponent model "1" M1 
        , radioComponent model "2" M2 
        , radioComponent model "3" M3 
        , radioComponent model "4" M4 
        , radioComponent model "5" M5 
        , radioComponent model "10" M10 
        , radioComponent model "Custom" Custom
        , customInputComponent model
        ]


radioIntervalTypeComponent : Model -> Html Msg
radioIntervalTypeComponent model =
    Html.form [ class "radio__interval__type__container" ]
        [ radio "Second" (model.radioIntervalType == Second) (SelectIntervalTimingType Second)
        , radio "Minute" (model.radioIntervalType == Minute) (SelectIntervalTimingType Minute)
        ]

radioUpsideDownComponent : Model -> Html Msg
radioUpsideDownComponent model =
    Html.form [ class "radio__upsidedown__container" ]
        [ radio "Yes" (model.radioUpsideDown == YesUpsideDown) (SelectUpsideDown YesUpsideDown)
        , radio "No" (model.radioUpsideDown == NoUpsideDown) (SelectUpsideDown NoUpsideDown) 
        ]


-- RADIO UPSIDE DOWN COMPONENT


radioComponent : Model -> String -> IntervalTiming -> Html Msg
radioComponent model text msg = 
    radio text (model.radioIntervalTiming == msg) (SelectIntervalTiming msg)

radio : String -> Bool -> Msg -> Html Msg
radio value isChecked msg =
  case isChecked of
    True ->
      label [ class "uncheckedRadio button is-primary is-outlined" ]
            [ input [ type_ "radio", name "font-size", onClick msg, checked isChecked ] []
            , text value                                -- this might need to be onInput?
            ]
    False ->
        label
            [ class "checkedRadio button" ]
            [ input [ type_ "radio", name "font-size", onClick msg, checked isChecked ] []
            , text value                                -- this might need to be onInput?
            ]


-- CUSTOM INPUT COMPONENTS

customInputComponent : Model -> Html Msg 
customInputComponent model =
    case model.radioIntervalType of 
        Second ->
            customInput model.radioIntervalTiming "How many seconds?"
        Minute ->
            customInput model.radioIntervalTiming "How many minutes?"
        

customInput : IntervalTiming -> String -> Html Msg
customInput radioInterval label_text =
    case radioInterval of
        Custom -> 
            div [ class "field" ] 
                [ h5 [ ] [ text label_text ]
                , div [ class "control" ]
                      [ input [ class "input", type_ "text", onInput UpdateCustomIntervalInput ] [] 
                      ]
                ]
        _ ->
            div [ style [("display", "none")] ] []          

