module Update exposing (..)

import Model exposing (..)
import Msg exposing (..)

import Command exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of        
        ChangeSearchInput inputValue ->
            -- case inputValue of
            --     "" ->
            -- { model | searchInput = inputValue } ! []
            --     _ ->
            { model | searchInput = inputValue } ! [fetchSearchQuery inputValue]

        SelectIntervalTimingType value ->
            case value of 
                Minute -> 
                    { model | radioIntervalType = value, radioIntervalTiming = M1 } ! []        

                Second -> 
                    { model | radioIntervalType = value, radioIntervalTiming = S30 } ! []        

        SelectIntervalTiming value ->
            { model | radioIntervalTiming = value } ! []

        UpdateCustomIntervalInput int ->
            case (String.toInt int) of
                Ok val ->
                    { model | radioIntervalCustomInput = val } ! []

                Err err ->
                    { model | error = err } ! []

        SelectCollection collection ->
            { model | selectedCollections = collection :: model.selectedCollections } ! []


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

        Tick newTime ->
            { model | imageTime = newTime} ! []

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