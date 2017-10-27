module Model exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline

import Time exposing (Time)


-- PRODUCT TYPES - COLLECTION

type alias Collection =
    { user_id : String
    , name : String
    , id : String
    , featured_image : String
    , display_name : String
    }

type alias CollectionList = 
    List Collection

type CollectionListType
    = SearchedCollectionList
    | SelectedCollectionList


-- PRODUCT TYPES - IMAGE

type alias ImageAssocList =
    List ImageAssoc

type alias ImageList =
    List Image 

type alias ImageAssoc =
    { name : String
    , image_url : String
    , id : String
    , display_name : String
    , times_drawn : Int
    , image_comments : ImageCommentList
    , image_scribbles : ImageScribbleList
    , image_tags : ImageTagList
    , image_drawings : ImageDrawingList
    }

type alias Image =
    { name : String
    , image_url : String
    , id : String
    , display_name : String
    , times_drawn : Int
    }


-- PRODUCT TYPES - IMAGE COMMENT

type alias ImageCommentList = 
    List ImageComment

type alias ImageComment =
    { id : String
    , text : String
    }


-- PRODUCT TYPES - IMAGE SCRIBBLE

type alias ImageScribbleList = 
    List ImageScribble

type alias ImageScribble =
    { id : String
    , name : String
    , display_name : String
    , description : String
    , data : String
    }


-- PRODUCT TYPES - IMAGE TAG

type alias ImageTagList = 
    List ImageTag

type alias ImageTag =
    { id : String
    , name : String
    , display_name : String
    }


-- PRODUCT TYPES - IMAGE DRAWING

type alias ImageDrawingList = 
    List ImageDrawing

type alias ImageDrawing =
    { id : String
    , name : String
    , display_name : String
    , description : String
    , image_url : String
    }


-- PRODUCT TYPES - IMAGE & COLLECTION

type alias CollectionImages =
    { user_id : String
    , name : String
    , id : String
    , featured_image: String
    , display_name: String
    , images: ImageList
    }

type alias CollectionImagesList =
    List CollectionImages 


-- SUM TYPES - Application Status

type Status
  = Initial
  | Loading
  | Start
  | Finish

type PopupStatus 
  = Resume
  | Pause

type DrawStatus
  = Normal
  | Draw 

type SelectCollecitonAction
  = AddSelectedCollection
  | RemoveSelectedCollection


-- SUM TYPES - Application Settings

type IntervalTimingType 
  = Second
  | Minute

type IntervalTiming 
  = S30
  | S45
  | S60
  | S90 
  | S120
  | M1
  | M2
  | M3
  | M4 
  | M5
  | M10 
  | Custom 

type UpsideDown 
  = YesUpsideDown
  | NoUpsideDown

type MinimalDistraction
  = YesMinimalDistraction
  | NoMinimalDistraction


-- MODEL 

type alias Model = 
    -- Search Functions
    { searchedCollections : CollectionList
    , selectedCollections : CollectionList

    , searchInput : String
    , popularQueries : (List String)

    -- Application Status
    , applicationStatus: Status
    , popupStatus : PopupStatus
    , imageStatus : DrawStatus

    -- Selection Criteria
    , radioIntervalType : IntervalTimingType
    , radioIntervalTiming : IntervalTiming
    , radioIntervalCustomInput : Int

    , radioUpsideDown : UpsideDown
    , radioDistraction : MinimalDistraction

    -- Popup Component
    , loadedImageAssocList : ImageAssocList
    , currentImage : ImageAssoc 

    , imageTime : Int 

    -- Errors 
    , error : String
    }



-- Collection Decoder

collectionListDecoder : Decode.Decoder CollectionList
collectionListDecoder =
    Decode.field "data" (Decode.list collectionDecoder)


collectionDecoder : Decode.Decoder Collection
collectionDecoder =
    Pipeline.decode Collection
        |> Pipeline.required "user_id" Decode.string        
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "featured_image" Decode.string
        |> Pipeline.required "display_name" Decode.string


-- IMAGE DECODER 

imageListDecoder : Decode.Decoder ImageList
imageListDecoder =
    Decode.list imageDecoder


imageDecoder : Decode.Decoder Image
imageDecoder =
    Pipeline.decode Image
        |> Pipeline.required "name" Decode.string        
        |> Pipeline.required "image_url" Decode.string
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "display_name" Decode.string
        |> Pipeline.required "times_drawn" Decode.int
        -- |> Pipeline.required "photo" Decode.string



-- IMAGE ASSOC DECODER 


imageAssocListDecoder : Decode.Decoder ImageAssocList
imageAssocListDecoder =
    Decode.field "data" (Decode.list imageAssocDecoder)


imageAssocDecoder : Decode.Decoder ImageAssoc
imageAssocDecoder =
    Pipeline.decode ImageAssoc
        |> Pipeline.required "name" Decode.string        
        |> Pipeline.required "image_url" Decode.string
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "display_name" Decode.string
        |> Pipeline.required "times_drawn" Decode.int
        |> Pipeline.required "image_comments" imageCommentListDecoder
        |> Pipeline.required "image_scribbles" imageScribbleListDecoder
        |> Pipeline.required "image_tags" imageTagListDecoder
        |> Pipeline.required "image_drawings" imageDrawingListDecoder



-- IMAGE ASSOC DECODER -- IMAGE COMMENTS

imageCommentListDecoder : Decode.Decoder ImageCommentList
imageCommentListDecoder =
    Decode.list imageCommentDecoder

imageCommentDecoder : Decode.Decoder ImageComment  
imageCommentDecoder =
    Pipeline.decode ImageComment
        |> Pipeline.required "id" Decode.string            
        |> Pipeline.required "text" Decode.string
        -- |> Pipeline.required "user_id" Decode.string        
        -- |> Pipeline.required "image_id" Decode.string        



-- IMAGE ASSOC DECODER -- IMAGE COMMENT

imageScribbleListDecoder : Decode.Decoder ImageScribbleList
imageScribbleListDecoder =
    Decode.list imageScribbleDecoder

imageScribbleDecoder : Decode.Decoder ImageScribble
imageScribbleDecoder =
    Pipeline.decode ImageScribble
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "name" Decode.string        
        |> Pipeline.required "display_name" Decode.string
        |> Pipeline.required "description" Decode.string
        |> Pipeline.required "data" Decode.string
        -- |> Pipeline.required "user_id" Decode.string
        -- |> Pipeline.required "image_id" Decode.string



-- IMAGE ASSOC DECODER -- IMAGE TAG

imageTagListDecoder : Decode.Decoder ImageTagList
imageTagListDecoder =
    Decode.list imageTagDecoder


imageTagDecoder : Decode.Decoder ImageTag
imageTagDecoder =
    Pipeline.decode ImageTag
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "name" Decode.string        
        |> Pipeline.required "display_name" Decode.string


-- IMAGE ASSOC DECODER -- IMAGE DRAWING

imageDrawingListDecoder : Decode.Decoder ImageDrawingList
imageDrawingListDecoder =
    Decode.list imageDrawingDecoder

imageDrawingDecoder : Decode.Decoder ImageDrawing
imageDrawingDecoder =
    Pipeline.decode ImageDrawing
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "name" Decode.string        
        |> Pipeline.required "display_name" Decode.string
        |> Pipeline.required "description" Decode.string
        |> Pipeline.required "image_url" Decode.string
        -- |> Pipeline.required "image_id" Decode.string
        -- |> Pipeline.required "user_id" Decode.string




-- Collection Image Decoder

collectionImageListDecoder : Decode.Decoder CollectionImagesList
collectionImageListDecoder =
    Decode.field "data" (Decode.list collectionImageDecoder)


collectionImageDecoder : Decode.Decoder CollectionImages
collectionImageDecoder =
    Pipeline.decode CollectionImages
        |> Pipeline.required "user_id" Decode.string        
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "id" Decode.string        
        |> Pipeline.required "featured_image" Decode.string
        |> Pipeline.required "display_name" Decode.string
        |> Pipeline.required "images" imageListDecoder


-- Collection Encoder 

collectionListEncoder : CollectionList -> Encode.Value
collectionListEncoder collectionList =
        Encode.list (List.map collectionEncoder collectionList)

collectionEncoder : Collection -> Encode.Value
collectionEncoder collection =
        Encode.object [ ("user_id", Encode.string collection.user_id)
                      , ("name", Encode.string collection.name)
                      , ("id", Encode.string collection.id) 
                      , ("featured_image", Encode.string collection.featured_image)
                      , ("display_name", Encode.string collection.display_name)]


-- Image Encoder 

imageListEncoder : ImageList -> Encode.Value
imageListEncoder imageList =
        Encode.list (List.map imageEncoder imageList)


imageEncoder : Image -> Encode.Value
imageEncoder image =
        Encode.object [ ("name", Encode.string image.name)
                      , ("image_url", Encode.string image.image_url)
                      , ("id", Encode.string image.id) 
                      , ("display_name", Encode.string image.display_name)]



-- Selected Collections Encoder 

selectedCollectionsListEncoder : CollectionList -> Encode.Value
selectedCollectionsListEncoder collectionList =
        Encode.list (List.map selectedCollectionsEncoder collectionList)

selectedCollectionsEncoder : Collection -> Encode.Value
selectedCollectionsEncoder collection =
        Encode.object [ ("id", Encode.string collection.id)]


-- Search Input Encoder 

searchInputEncoder : String -> Encode.Value
searchInputEncoder searchInput =    
        Encode.object [ ("search_input", Encode.string searchInput)]


