module Component.RadioComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)




-- SECOND/MINUTE RADIO COMPONENTS

radioComponent : Model -> Html Msg 
radioComponent model =
    div [] 
        [ radioIntervalTypeComponent model
        , h5 [] [ text "Image timing" ]
        , radioIntervalSecondsOrMinutesComponent model 
        , h5 [] [ text "Display image upside down?" ]            
        , radioUpsideDownComponent model
        ]

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
        [ radioWrapper model "30" S30
        , radioWrapper model "45" S45
        , radioWrapper model "60" S60
        , radioWrapper model "90" S90
        , radioWrapper model "120" S120
        , radioWrapper model "Custom" Custom
        , customInputComponent model
        ]


radioIntervalMinutesComponent : Model -> Html Msg
radioIntervalMinutesComponent model =
    Html.form [ class "radio__interval__timing__container" ]
        [ radioWrapper model "1" M1 
        , radioWrapper model "2" M2 
        , radioWrapper model "3" M3 
        , radioWrapper model "4" M4 
        , radioWrapper model "5" M5 
        , radioWrapper model "10" M10 
        , radioWrapper model "Custom" Custom
        , customInputComponent model
        ]

radioWrapper : Model -> String -> IntervalTiming -> Html Msg
radioWrapper model text msg = 
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



-- INTERVAL TYPE/UPSIDE DOWN RADIO COMPONENTS

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


-- CUSTOM INPUT COMPONENTS

customInputComponent : Model -> Html Msg 
customInputComponent model =
    case model.radioIntervalType of 
        Second ->
            customInput model.radioIntervalTiming "How many seconds?" model.error
        Minute ->
            customInput model.radioIntervalTiming "How many minutes?" model.error
        

customInput : IntervalTiming -> String -> String -> Html Msg
customInput radioInterval label_text error =
    case radioInterval of
        Custom -> 
            div [ class "field" ] 
                [ h5 [ ] [ text label_text ]
                , div [ class "control" ]
                      [ input [ class "input", type_ "text", onInput UpdateCustomIntervalInput ] [] 
                      ]
                , p [] [ text error ]
                ]
        _ ->
            div [ style [("display", "none")] ] []          

