module Msg exposing (..)

import Model exposing (..)

import Http exposing (..)

type Msg
    = ChangeSearchInput String

    | SelectIntervalTiming IntervalTiming
    | SelectUpsideDown UpsideDown

    | ChangeStatus Status
    | ChangePopupStatus PopupStatus

    | FetchCollectionListFail Error
    | FetchCollectionListSuccess CollectionList

    | InitialFetchQueryFail Error
    | InitialFetchQuerySuccess CollectionList

    | FetchCollectionStartAppFail Error 
    | FetchCollectionStartAppSuccess CollectionImagesList
