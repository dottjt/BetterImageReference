module Update exposing (..)

import Model exposing (..)
import Msg exposing (..)

import Command exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of        
        ChangeSearchInput inputValue ->
            { model | searchInput = inputValue } ! [fetchSearchQuery inputValue]

        SelectIntervalTiming value ->
            { model | radioInterval = value } ! []

        SelectUpsideDown value ->
            { model | radioUpsideDown = value } ! []

        -- BEGIN TOOL
        ChangeStatus status ->
            { model | applicationStatus = status } ! []
        
        ChangePopupStatus status ->
            { model | popupStatus = status } ! []

        -- INITIAL FETCH
        InitialFetchQuerySuccess response ->
            { model | searchedCollections = response } ! []

        InitialFetchQueryFail error -> 
            { model | error = toString error } ! []
            
        -- QUERY FETCH
        FetchCollectionListSuccess response ->
            { model | searchedCollections = response } ! []

        FetchCollectionListFail error ->
            { model | error = toString error } ! []


        -- START APPLICATION IMAGE FETCH
        FetchCollectionStartAppSuccess response ->
            { model | loadedCollectionsWithImages = response } ! []        

        FetchCollectionStartAppFail error ->
            { model | error = toString error } ! []