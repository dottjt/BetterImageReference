module Command exposing (..)

import Model exposing (..)
import Msg exposing (..)
import Helper.HttpHelper exposing (..)

import Http exposing (..)



-- Initial Request

initialFetchQuery : Cmd Msg
initialFetchQuery =
    httpGet
        "http://localhost:4000/api/collections_initial_load_search"
        collectionListDecoder
        InitialFetchQueryFail
        InitialFetchQuerySuccess


fetchSearchQuery : String -> Cmd Msg
fetchSearchQuery searchInput =
    httpPost
        ("http://localhost:4000/api/collections/collection_search_query")
        (Http.jsonBody (searchInputEncoder searchInput))          
        collectionListDecoder
        FetchCollectionListFail
        FetchCollectionListSuccess


-- Start Application

startAppFetchImages : CollectionList -> Cmd Msg
startAppFetchImages collectionList =
    httpPost
        ("http://localhost:4000/api/collections_initial_load_app")
        (Http.jsonBody (selectedCollectionsListEncoder collectionList))          
        imageAssocListDecoder
        FetchImageStartAppFail
        FetchImageStartAppSuccess


