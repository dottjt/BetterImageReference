module Msg exposing (..)

import Model exposing (..)

import Http exposing (..)
import Time exposing (..)

type Msg
    = ChangeSearchInput String

    | SelectIntervalTiming IntervalTiming
    | UpdateCustomIntervalInput Int
    | SelectUpsideDown UpsideDown
    | SelectCollection Collection

    | ChangeStatus Status
    | ChangePopupStatus PopupStatus
    | ChangeDrawStatus DrawStatus

    | ImageTimer Time
    | ImageTimerBarProgress

    | FetchCollectionListFail Error
    | FetchCollectionListSuccess CollectionList

    | InitialFetchQueryFail Error
    | InitialFetchQuerySuccess CollectionList

    | FetchCollectionStartAppFail Error 
    | FetchCollectionStartAppSuccess CollectionImagesList
