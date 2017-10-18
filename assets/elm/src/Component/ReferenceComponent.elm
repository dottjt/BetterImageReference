module Component.ReferenceComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)
import Update exposing (..)

import Component.RadioComponent exposing (..)
import Component.SearchComponent exposing (..)
import Component.PopupComponent exposing (..)


referenceComponent : Model -> Html Msg
referenceComponent model = 
  case model.applicationStatus of 
      Start ->
        div [ class "reference__tool__start" ]
            [ popupComponent model ]
  
      Stop -> 
        div [ class "reference__tool__stop"]
            [ selectionComponent model
            , radioIntervalComponent model
            , radioUpsideDownComponent model 
            , submitComponent
            ]

      Loading ->
        div [ class "reference__tool__loading"]
            [ text "Fetching images, please wait" ]





submitComponent : Html Msg 
submitComponent = 
  div [] 
      [ button [ onClick (ChangeStatus Start) ] [ text "hellothere" ]]



