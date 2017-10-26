module Msg exposing (..)

import Model exposing (..)

import Http exposing (..)
import Time exposing (..)

type Msg
    = ChangeSearchInput String

    | SelectIntervalTimingType IntervalTimingType
    | SelectIntervalTiming IntervalTiming
    | UpdateCustomIntervalInput String
    | SelectUpsideDown UpsideDown
    
    | SelectCollection Collection SelectCollecitonAction

    | ChangeStatus Status
    | ChangePopupStatus PopupStatus
    | ChangeDrawStatus DrawStatus

    | Tick Time
    | ImageTimerBarProgress

    | FetchCollectionListFail Error
    | FetchCollectionListSuccess CollectionList

    | InitialFetchQueryFail Error
    | InitialFetchQuerySuccess CollectionList

    | FetchCollectionStartAppFail Error 
    | FetchCollectionStartAppSuccess CollectionImagesList
