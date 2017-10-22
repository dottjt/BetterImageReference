module Component.ReferenceSearchComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)

import Component.SearchComponent exposing (searchInput)


-- REFERENCE VIEW 

selectionComponent : Model -> Html Msg
selectionComponent model =
    div [ class "selectionComponent"]
        [ searchInput model.searchInput
        , searchedCollections model.searchedCollections
        , selectedCollections model.selectedCollections
        ]

-- REFERENCE VIEW 

searchedCollections : CollectionList -> Html Msg
searchedCollections collectionList =
    div [ class "columns is-multiline is-tablet" ]
        (List.map searchTile collectionList)

selectedCollections : CollectionList -> Html Msg
selectedCollections collectionList = 
    div [ class "columns is-multiline is-tablet" ]
        (List.map searchTile collectionList)


searchTile : Collection -> Html Msg
searchTile collection =
    div [ class "column is-12 reference_search__tile__container", onClick collection ]
        [ a [ href ("/collections/" ++ collection.name) ] 
            [ img [ class "search__image", src collection.featured_image ] []
            ]
        , div [ class "search__information__container"] [
            a [ class "search__tile__link", href ("/collections/" ++ collection.name) ] 
            [ h4 [ class "search__tile__display__name" ] [ text collection.display_name ]
            ]
        , div [ class "search__details" ]
            [ h5 []
                [ text "Times drawn variable" ]
            ]
        ]
        ]

-- SEARCH VIEW

searchComponent : Model -> Html Msg
searchComponent model =
    div [ class "search__container"]
        [ searchInput model.searchInput
        , searchedCollections model.searchedCollections
        ]
