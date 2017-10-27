module Update exposing (..)

import Model exposing (..)
import Msg exposing (..)

import Command exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of        

        -- SEARCH UPDATES  

        ChangeSearchInput inputValue ->
            { model | searchInput = inputValue } ! [fetchSearchQuery inputValue]


        SelectCollection collection selectAction ->
            case selectAction of 
                AddSelectedCollection -> 
                    { model | selectedCollections = collection :: model.selectedCollections } ! []

                RemoveSelectedCollection ->
                    { model | selectedCollections = List.filter (\x -> x.id /= collection.id) model.selectedCollections } ! []



        -- RADIO BUTTON UPDATES  

        SelectIntervalTimingType value ->
            case value of 
                Minute -> 
                    { model | radioIntervalType = value, radioIntervalTiming = M1, radioIntervalCustomInput = 0 } ! []        

                Second -> 
                    { model | radioIntervalType = value, radioIntervalTiming = S30, radioIntervalCustomInput = 0 } ! []        

        SelectIntervalTiming value ->
            { model | radioIntervalTiming = value } ! []

        UpdateCustomIntervalInput int ->
            case model.radioIntervalType of
                Second -> 
                    case (String.toInt int) of
                        Ok val ->
                            { model | radioIntervalCustomInput = val } ! []

                        Err err ->
                            { model | error = err } ! []
                Minute -> 
                    case (String.toInt int) of
                        Ok val ->
                            { model | radioIntervalCustomInput = (val * 60) } ! []

                        Err err ->
                            { model | error = err } ! []

        SelectUpsideDown value ->
            { model | radioUpsideDown = value } ! []



        -- APPLICATION STATUS UPDATES

        ChangeStatus status ->
            case status of 
                Start ->
                    { model | applicationStatus = status } ! [startAppFetchImages model.selectedCollections]
                Finish ->
                    { model | applicationStatus = status } ! []
                _ -> -- Stop, Finish, Loading
                    { model | applicationStatus = status } ! []            

        ChangePopupStatus status ->
            { model | popupStatus = status } ! []

        ChangeDrawStatus status ->
            { model | imageStatus = status } ! []



        -- TIME UPDATES

        Tick newTime ->
            -- okay, you need to create a function that grabs the current imageList and then sends it the next one. 
            if model.imageTime == 0 then 
                { model | imageTime = (model.imageTime - 1) } ! []            
            else 
                calculateIntervalTiming model



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

        FetchImageStartAppSuccess response ->
            { model | loadedImageAssocList = response } ! []        

        FetchImageStartAppFail error ->
            { model | error = toString error } ! []




calculateIntervalTiming : Model -> (Model, Cmd Msg)
calculateIntervalTiming model = 
    let 
        imageTime = model.imageTime
        customTime = model.radioIntervalCustomInput 
    in
    case model.radioIntervalTiming of
        S30 -> { model | imageTime = 30 } ! []
        S45 -> { model | imageTime = 45 } ! []
        S60 -> { model | imageTime = 60 } ! []
        S90 -> { model | imageTime = 90 } ! []
        S120 -> { model | imageTime = 120 } ! []
        M1 -> { model | imageTime = 60 } ! []
        M2 -> { model | imageTime = 120 } ! []
        M3 -> { model | imageTime = 180 } ! []
        M4 -> { model | imageTime = 240 } ! []
        M5 -> { model | imageTime = 300 } ! []
        M10 -> { model | imageTime = 600 } ! []
        Custom -> { model | imageTime = customTime } ! []                    
            