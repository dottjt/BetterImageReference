module Component.PopupComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import Update exposing (..)


popupNavbar : Model -> Html Msg
popupNavbar model =
    div [ class "popup__navbar"] 
        [ button [ class "draw__button", onClick (ChangeDrawStatus Draw) ] [ text "draw" ] 
        ]


popupLeftbar : Model -> Html msg 
popupLeftbar model =
    div [ class "popup__leftbar"] 
        [ div [] 
              [ h4 [] [ text "User Comments" ] 
              , div [] [] 
              ]
        , div [] 
              [ h4 [] [ text "User Scribbles" ] 
              , div [] [] 
              ]
        , div [] 
              [ h4 [] [ text "User Drawings" ] 
              , div [] [] 
              ]
        ]


popupMiddlebar : Model -> Html Msg
popupMiddlebar model =
    div [ class "popup__middlebar"]
        [ div [ class "image__container"]
              [ img [ class "image", src "" ] []
              ]
        ]


popupBottombar : Model -> Html Msg 
popupBottombar model =
    div [ class "popup__bottombar"] 
        [ div [ class "skip__pause__stop__container"]
              [ div [ class "button__row"]
                    [ button [ class "button" ] [ text "Skip" ]
                    , popupPauseResumeButton model.popupStatus
                    , button [ class "button", onClick (ChangeStatus Finish) ] [ text "Stop" ]                    
              ]
              , div [ class "timing__bar"]
                    [ text "this is where the timing bar goes"]
              ]
        ]


popupPauseResumeButton : PopupStatus -> Html Msg
popupPauseResumeButton popupStatus =
    case popupStatus of
        Pause ->
            button [ class "button", onClick (ChangePopupStatus Resume) ] [ text "Pause" ]

        Resume ->
            button [ class "button", onClick (ChangePopupStatus Pause) ] [ text "Resume" ]