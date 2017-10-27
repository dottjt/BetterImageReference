module Component.ReferenceComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)
import Model exposing (..)
import Update exposing (..)

import Component.RadioComponent exposing (..)
import Component.ReferenceSearchComponent exposing (..)
import Component.SearchComponent exposing (..)
import Component.PopupComponent exposing (..)
import Component.FinishComponent exposing (..)




referenceComponent : Model -> Html Msg
referenceComponent model =
    case model.applicationStatus of

      Initial -> 
        div [ class "reference__tool__stop"]
            [ selectionReferenceComponent model
            , radioComponent model
            , submitComponent
            ]

      Loading ->
        div [ class "reference__tool__loading"]
            [ text "Fetching images, please wait" ]

      Start ->
        div [ class "reference__tool__start" ]
            [ div [ class "inner" ]
                  [ popupNavbar model.currentImage
                  , popupLeftbar model.currentImage
                  , popupMiddlebar model.popupStatus model.currentImage
                  , popupBottombar model
                  ]
            ]

      Finish -> 
        div [ class "reference__tool__finish"]
            [ displayDrawnCollections model.loadedImageAssocList
            , selectionReferenceComponent model
            ]






