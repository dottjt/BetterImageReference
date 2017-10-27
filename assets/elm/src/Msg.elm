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

    | FetchCollectionListFail Error
    | FetchCollectionListSuccess CollectionList

    | InitialFetchQueryFail Error
    | InitialFetchQuerySuccess CollectionList

    | FetchImageStartAppFail Error 
    | FetchImageStartAppSuccess ImageAssocList
