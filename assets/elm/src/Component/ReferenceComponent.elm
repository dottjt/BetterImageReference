module Component.ReferenceComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.RadioComponent exposing (..)
import Component.SearchComponent exposing (..)
import Component.PopupComponent exposing (..)
import Component.FinishComponent exposing (..)


referenceComponent : Model -> Html Msg
referenceComponent model = 
  case model.applicationStatus of 
      Start ->
        div [ class "reference__tool__start" ]
            [ div [ class "outer"] 
                  [ popupLeftbar model
                  , popupBottombar model]
            , div [ class "inner"]
                  [ popupNavbar model
                  , popupMiddlebar model
                  ]
            ]
  
      Stop -> 
        div [ class "reference__tool__stop"]
            [ selectionComponent model
            , radioIntervalComponent model
            , radioUpsideDownComponent model 
            , submitComponent
            ]

      Finish -> 
        div [ class "reference__tool__finish"]
            [ displayDrawnCollections model.loadedCollectionImagesList ]

      Loading ->
        div [ class "reference__tool__loading"]
            [ text "Fetching images, please wait" ]





