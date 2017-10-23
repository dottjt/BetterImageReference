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


radioIntervalTypeComponent : Model -> Html Msg
radioIntervalTypeComponent model =
    Html.form [ class "radio__interval__type__container" ]
        [ radio "Second" (model.radioIntervalType == Second) (SelectIntervalTimingType Second)
        , radio "Minute" (model.radioIntervalType == Minute) (SelectIntervalTimingType Minute)
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
        [ radio "30" (model.radioIntervalTiming == S30) (SelectIntervalTiming S30)
        , radio "45" (model.radioIntervalTiming == S45) (SelectIntervalTiming S45)
        , radio "60" (model.radioIntervalTiming == S60) (SelectIntervalTiming S60)
        , radio "90" (model.radioIntervalTiming == S90) (SelectIntervalTiming S90)
        , radio "120" (model.radioIntervalTiming == S120) (SelectIntervalTiming S120)
        , radio "Custom" (model.radioIntervalTiming == Custom) (SelectIntervalTiming Custom)
        , customInputComponent model
        ]


radioIntervalMinutesComponent : Model -> Html Msg
radioIntervalMinutesComponent model =
    Html.form [ class "radio__interval__timing__container" ]
        [ radio "1" (model.radioIntervalTiming == M1) (SelectIntervalTiming M1)
        , radio "2" (model.radioIntervalTiming == M2) (SelectIntervalTiming M2)
        , radio "3" (model.radioIntervalTiming == M3) (SelectIntervalTiming M3)
        , radio "4" (model.radioIntervalTiming == M4) (SelectIntervalTiming M4)
        , radio "5" (model.radioIntervalTiming == M5) (SelectIntervalTiming M5)
        , radio "10" (model.radioIntervalTiming == M10) (SelectIntervalTiming M10)
        , radio "Custom" (model.radioIntervalTiming == Custom) (SelectIntervalTiming Custom)
        , customInputComponent model
        ]


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



-- RADIO UPSIDE DOWN COMPONENT

radioUpsideDownComponent : Model -> Html Msg
radioUpsideDownComponent model =
    Html.form [ class "radio__upsidedown__container" ]
        [ radio "Yes" (model.radioUpsideDown == YesUpsideDown) (SelectUpsideDown YesUpsideDown)
        , radio "No" (model.radioUpsideDown == NoUpsideDown) (SelectUpsideDown NoUpsideDown) 
        ]


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
        