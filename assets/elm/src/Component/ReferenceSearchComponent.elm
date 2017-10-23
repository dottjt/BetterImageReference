module Component.ReferenceSearchComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.SearchComponent exposing (searchInput)


-- REFERENCE VIEW 

selectionReferenceComponent : Model -> Html Msg
selectionReferenceComponent model =
    div [ class "selectionComponent"]
        [ searchInput model.searchInput
        , h2 [] [ text "Select a collection" ]
        , searchedReferenceCollections model.searchedCollections
        , h2 [] [ text "Selected collections"]
        , selectedReferenceCollections model.selectedCollections
        ]

-- REFERENCE VIEW 

searchedReferenceCollections : CollectionList -> Html Msg
searchedReferenceCollections collectionList =
    div [ class "columns is-multiline is-tablet" ]
        (List.map searchReferenceTile collectionList)

selectedReferenceCollections : CollectionList -> Html Msg
selectedReferenceCollections collectionList = 
    case collectionList of 
            [] ->
                div [ ]
                    [ text "Please select a collection!"]
            _ ->
                div [ class "columns is-multiline is-tablet" ]
                    (List.map searchReferenceTile collectionList)


searchReferenceTile : Collection -> Html Msg
searchReferenceTile collection =
    div [ class "column is-12 reference_search__tile__container", onClick (SelectCollection collection) ]
        [ div [ class "search__image__container" ]
              [ img [ class "search__image", src collection.featured_image ] []
              ]
        , div [ class "search__information__container" ] 
              [ h4 [ class "search__tile__display__name" ] 
                   [ text collection.display_name ]
              ,  a [ class "search__tile__link", href ("/collections/" ++ collection.name) ]
                   [ text "View Collection"]
              , h5 [] 
                   [ text "times drawn" ] 
              ] 
        ]
        
        
