module Command exposing (..)

import Model exposing (..)
import Msg exposing (..)
import Helper.HttpHelper exposing (..)

import Http exposing (..)



-- Initial Request

initialFetchQuery : Cmd Msg
initialFetchQuery =
    httpGet
        "http://localhost:4000/api/collections"
        collectionListDecoder
        InitialFetchQueryFail
        InitialFetchQuerySuccess


fetchSearchQuery : String -> Cmd Msg
fetchSearchQuery searchInput =
    httpPost
        ("http://localhost:4000/api/collections/" ++ searchInput)
        (Http.jsonBody (searchInputEncoder searchInput))          
        collectionListDecoder
        FetchCollectionListFail
        FetchCollectionListSuccess



-- Start Application

startAppFetchImages : CollectionList -> Cmd Msg
startAppFetchImages collectionList =
    httpPost
        ("http://localhost:4000/api/collections/image_list")
        (Http.jsonBody (collectionListEncoder collectionList))          
        collectionImageListDecoder
        FetchCollectionStartAppFail
        FetchCollectionStartAppSuccess



