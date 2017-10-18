module Model exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


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


-- PRODUCT TYPES - IMAGE

type alias Image =
    { name : String
    , image_url : String
    , id : String
    , display_name : String
    }

type alias ImageList =
    List Image 


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
  = Start
  | Loading
  | Stop
  | Finish 

type PopupStatus 
  = Pause
  | Resume

type DrawStatus
  = Normal
  | Draw 


-- SUM TYPES - Application Settings

type UpsideDown 
  = YesUpsideDown
  | NoUpsideDown

type MinimalDistraction
  = YesMinimalDistraction
  | NoMinimalDistraction

type IntervalTiming 
  = I30
  | I45
  | I60
  | I90 
  | I120
  | Custom 


-- MODEL 

type alias Model = 
    -- Search Functions
    { searchedCollections : CollectionList
    , selectedCollections : CollectionList
    , searchInput : String

    -- Application Status
    , applicationStatus: Status
    , popupStatus : PopupStatus
    , imageStatus : DrawStatus

    -- Selection Criteria
    , radioInterval : IntervalTiming
    , radioUpsideDown : UpsideDown
    , radioDistraction : MinimalDistraction

    -- Popup Component
    , loadedCollectionsWithImages : CollectionImagesList

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


-- Image Decoder

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


-- Collection Image Encoder 

-- collectionImageEncoder : Collection -> Encode.Value
-- collectionImageEncoder collection =
--         Encode.object [ ("user_id", Encode.string collection.user_id)
--                       , ("name", Encode.string collection.name)
--                       , ("id", Encode.string collection.id) 
--                       , ("featured_image", Encode.string collection.featured_image)
--                       , ("display_name", Encode.string collection.display_name)
--                       , ("images", (List.map imageEncoder collection.images))]


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



-- Search Input Encoder 

searchInputEncoder : String -> Encode.Value
searchInputEncoder searchInput =    
        Encode.string searchInput
