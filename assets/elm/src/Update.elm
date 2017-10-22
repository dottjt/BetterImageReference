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

        UpdateCustomIntervalInput int ->
            { model | radioIntervalCustomInput = int } ! []        

        SelectCollection collection ->
            { model | selectedCollections = model.selectedCollections :: collection } ! []

        SelectUpsideDown value ->
            { model | radioUpsideDown = value } ! []

        -- BEGIN TOOL
        ChangeStatus status ->
            { model | applicationStatus = status } ! [startAppFetchImages model.selectedCollections]
        
        ChangePopupStatus status ->
            { model | popupStatus = status } ! []

        -- TOOL FUNCTIONALITY
        ChangeDrawStatus status ->
            { model | imageStatus = status } ! []

        ImageTimer time -> 
            model ! []

        ImageTimerBarProgress ->
            model ! []

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
            { model | loadedCollectionImagesList = response } ! []        

        FetchCollectionStartAppFail error ->
            { model | error = toString error } ! []