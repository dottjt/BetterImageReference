module Component.SearchComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)


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
    div [ class "column is-3" ]
        [ a [ href ("/collections/" ++ collection.name) ] 
            [ img [ class "search__image", src collection.featured_image ] []
            ]
        , a [ href ("/collections/" ++ collection.name) ] 
            [ h4 [ class "search__title" ] [ text collection.display_name ]
            ]
        , div [ class "search__details" ]
            [ h5 []
                [ text "Times drawn variable" ]
            ]
        ]

-- SEARCH VIEW

searchComponent : Model -> Html Msg
searchComponent model =
    div [ class "search__container"]
        [ searchInput model.searchInput
        , searchedCollections model.searchedCollections
        ]

searchInput : String -> Html Msg 
searchInput searchInputValue =
    div [ class "search__input__container" ] 
        [ input [ class "search__input", type_ "text", placeholder "", value searchInputValue, onInput ChangeSearchInput ] []
        ]




submitComponent : Html Msg 
submitComponent = 
  div [] 
      [ button [ onClick (ChangeStatus Start) ] [ text "Start" ]]
