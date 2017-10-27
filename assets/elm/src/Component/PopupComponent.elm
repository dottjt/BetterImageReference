module Component.PopupComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)



-- POPUP NAVBAR

popupNavbar : ImageAssoc -> Html Msg
popupNavbar imageAssoc =
    div [ class "popup__navbar"] 
        [ button [ class "draw__button", onClick (ChangeDrawStatus Draw) ] [ text "draw" ] 
        ]



-- POPUP LEFTBAR

popupLeftbar : ImageAssoc -> Html msg 
popupLeftbar imageAssoc =
    div [ class "popup__leftbar"] 
        [ div [] 
              [ h4 [] [ text "User Comments" ] -- Image Comments
              , div [] (List.map userComments imageAssoc.image_comments) 
              ]
        , div [] 
              [ h4 [] [ text "User Scribbles" ]
              , div [] (List.map userScribbles imageAssoc.image_scribbles) 
              ]
        , div [] 
              [ h4 [] [ text "User Drawings" ] -- 
              , div [] (List.map userDrawings imageAssoc.image_drawings) 
              ]
        ]


userComments : ImageComment -> Html msg
userComments imageComment =
    div [] 
        [ img [] [ text "avatar"]
        , h4 [] [ text "I guess it would be the username?" ]
        , p [] [ text imageComment.text ]
        ]

userScribbles : ImageScribble -> Html msg
userScribbles imageScribble =
    div [] 
        [ img [] [ text "" ]
        , h4 [] [ text imageScribble.display_name ]
        ]

userDrawings : ImageDrawing -> Html msg
userDrawings imageDrawing =
    div [] 
        [ img [] [ text imageDrawing.image_url ]
        , h4 [] [ text imageDrawing.display_name ]
        , h4 [] [ text imageDrawing.description ]
        
        ]



-- POPUP MIDDLEBAR

popupMiddlebar : PopupStatus -> ImageAssoc -> Html Msg
popupMiddlebar popupStatus currentImage =
      case popupStatus of
            Resume ->
                div [ class "popup__middlebar"]
                    [ div [ class "image__container"]
                        [ img [ class "image", src currentImage.image_url ] []
                        ]
                    ]
            Pause ->
                div [ class "popup__middlebar"]
                    [ div [ class "image__container image__container--pause"]
                        [ img [ class "image", src currentImage.image_url , style [("display", "none")] ] []
                        ]
                    ]



-- POPUP BOTTOMBAR

popupBottombar : Model -> Html Msg 
popupBottombar model =
    div [ class "popup__bottombar" ] 
        [ div [ class "skip__pause__stop__container" ]
              [ popupBottomButtons model
              , popupTimingBar model
              ]
        ]
        

popupBottomButtons : Model -> Html Msg 
popupBottomButtons model =
    div [ class "button__row"]
        [ button [ class "button" ] [ text "Skip" ]
        , popupPauseResumeButton model.popupStatus
        , button [ class "button", onClick (ChangeStatus Finish) ] [ text "Stop" ]
        ]



popupPauseResumeButton : PopupStatus -> Html Msg
popupPauseResumeButton popupStatus =
    case popupStatus of
        Pause ->
            button [ class "button", onClick (ChangePopupStatus Resume) ] [ text "Pause" ]

        Resume ->
            button [ class "button", onClick (ChangePopupStatus Pause) ] [ text "Resume" ]



popupTimingBar : Model -> Html Msg
popupTimingBar model = 
    div [ class "timing__bar", style [("display", "none")] ]
        [ text "timing bar" ]
