module Component.SearchComponent exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msg exposing (..)
import Model exposing (..)


-- SEARCH VIEW

searchComponent : Model -> Html Msg
searchComponent model =
    div [ class "search__container"]
        [ searchInput model.searchInput
        , popularQueries model.popularQueries
        , searchedCollections model.searchedCollections
        ]

searchInput : String -> Html Msg 
searchInput searchInput =
    div [ class "field search__input__container" ] 
        [ label [ class "label" ] []
        , div [ class "control" ]
              [ input [ class "input search__input", type_ "text", placeholder "", value searchInput, onInput ChangeSearchInput ] []
              ]
        ]


-- POPULAR QUERIES

popularQueries : (List String) -> Html Msg
popularQueries popularQueries =  
    div [ class "popular__queries__container"] 
        [ h5 [ class "" ] [ text "popular searches" ]
        , div [ class "popular__queries__container__text" ] (List.map popularQueryText popularQueries)
        ]

    

popularQueryText : String -> Html Msg 
popularQueryText popularQuery =
    a [ class "popular__queries__text is-link", onClick (ChangeSearchInput popularQuery) ] [ text popularQuery ]


-- SEARCHED COLLECTIONS

searchedCollections : CollectionList -> Html Msg
searchedCollections collectionList =
    div [ class "columns is-multiline is-tablet searched__collections__container" ]
        (List.map searchTile collectionList)

searchTile : Collection -> Html Msg
searchTile collection =
    div [ class "column is-3 search__tile__container" ]
        [ a [ href ("/collections/" ++ collection.name) ] 
            [ img [ class "search__image", src collection.featured_image ] []
            ]
        , div [ class "search__information__container"] 
              [
                a [ class "search__tile__link", href ("/collections/" ++ collection.name) ] 
                  [ h4 [ class "search__tile__display__name" ] [ text collection.display_name ]
                  ]
                , h5 [] 
                     [ text "times drawn"] 
              ]

        ]


-- SUBMIT BUTTON 

submitComponent : Html Msg 
submitComponent = 
  div [] 
      [ button [ class "button is-primary", onClick (ChangeStatus Start) ] [ text "Start" ]]
