module Component.ReferenceComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.RadioComponent exposing (..)
import Component.ReferenceSearchComponent exposing (..)
import Component.SearchComponent exposing (..)
import Component.PopupComponent exposing (..)
import Component.FinishComponent exposing (..)


referenceComponent : Model -> Html Msg
referenceComponent model =
  case model.applicationStatus of
      Start ->
        div [ class "reference__tool__start" ]
            [ div [ class "outer"]
                  [ ]
            , div [ class "inner"]
                  [ popupNavbar model
                  , popupLeftbar model
                  , popupMiddlebar model
                  , popupBottombar model
                  ]
            ]

      Stop -> 
        div [ class "reference__tool__stop"]
            [ selectionReferenceComponent model
            , h5 [] [ text "Image timing" ]
            , radioIntervalComponent model
            , h5 [] [ text "Display image upside down?" ]            
            , radioUpsideDownComponent model 
            , submitComponent
            ]

      Finish -> 
        div [ class "reference__tool__finish"]
            [ displayDrawnCollections model.loadedCollectionImagesList
            , selectionReferenceComponent model
            ]

      Loading ->
        div [ class "reference__tool__loading"]
            [ text "Fetching images, please wait" ]





