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
    div [ class "selection__component"]
        [ searchInput model.searchInput
        , h2 [] [ text "Select a collection" ]
        , searchReferenceTiles model.searchedCollections SearchedCollectionList
        , h2 [] [ text "Selected collections"]
        , searchReferenceTiles model.selectedCollections SelectedCollectionList
        ]


-- REFERENCE VIEW

searchReferenceTiles : CollectionList -> CollectionListType -> Html Msg
searchReferenceTiles collectionList collectionType =
    case collectionType of
        SearchedCollectionList ->
            div [ class "columns is-multiline is-tablet" ]
                    (List.map searchedReferenceTile collectionList) 
        SelectedCollectionList -> 
            div [ class "columns is-multiline is-tablet" ]
                    (List.map selectedReferenceTile collectionList)


searchedReferenceTile : Collection -> Html Msg
searchedReferenceTile collection =
    searchTile collection AddSelectedCollection "Add to selection"

selectedReferenceTile : Collection -> Html Msg
selectedReferenceTile collection =
    searchTile collection RemoveSelectedCollection "Selected!"

        
searchTile : Collection -> SelectCollecitonAction -> String -> Html Msg
searchTile collection selectCollectionMsg selectedText =
    a [ class "column is-3 reference__search__tile__container" ]
        [ a [] 
            [ div [ class "click__to__select", onClick (SelectCollection collection selectCollectionMsg) ] [ text selectedText ]
            , img [ class "search__image", src collection.featured_image ] []
            ]
        , div [ class "search__information__container"] 
              [
                a [ class "search__tile__link", href ("/collections/" ++ collection.name) ] 
                  [ h4 [ class "search__tile__display__name" ] [ text collection.display_name ]
                  ]
              ,  a [ class "search__tile__link", href ("/collections/" ++ collection.name) ]
                   [ text "View Collection"]
              ]

        ]
        


-- searchReferenceTile : Collection -> Html Msg
-- searchReferenceTile collection =
--     div [ class "column is-12 reference_search__tile__container", onClick (SelectCollection collection) ]
--         [ div [ class "search__image__container" ]
--               [ img [ class "search__image", src collection.featured_image ] []
--               ]
--         , div [ class "search__information__container" ] 
--               [ h4 [ class "search__tile__display__name" ] 
--                    [ text collection.display_name ]
--               ,  a [ class "search__tile__link", href ("/collections/" ++ collection.name) ]
--                    [ text "View Collection"]
--               , h5 [] 
--                    [ text "times drawn" ] 
--               ] 
--         ]
        
        
