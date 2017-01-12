port module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (..)
import Json.Encode


port schedule : (Json.Encode.Value -> msg) -> Sub msg


port updates : (Json.Encode.Value -> msg) -> Sub msg


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { schedule : List ScheduleItem
    , updates : List UpdateItem
    }


type alias ScheduleItem =
    { event : String
    , location : String
    , tag : String
    , time : Int
    }


type alias UpdateItem =
    { title : String
    , description : String
    , tag : String
    , time : Int
    }


init : ( Model, Cmd msg )
init =
    ( Model [] [], Cmd.none )


type Msg
    = ScheduleChange Json.Encode.Value
    | UpdatesChange Json.Encode.Value


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    let
        scheduleDecoder =
            list <|
                map4 ScheduleItem
                    (field "event" string)
                    (field "location" string)
                    (field "tag" string)
                    (field "time" int)

        updatesDecoder =
            list <|
                map4 UpdateItem
                    (field "title" string)
                    (field "description" string)
                    (field "tag" string)
                    (field "time" int)
    in
        case msg of
            ScheduleChange value ->
                case decodeValue scheduleDecoder value of
                    Ok schedule ->
                        ( { model | schedule = schedule }, Cmd.none )

                    Err _ ->
                        ( model, Cmd.none )

            UpdatesChange value ->
                case decodeValue updatesDecoder value of
                    Ok updates ->
                        ( { model | updates = updates }, Cmd.none )

                    Err _ ->
                        ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ schedule ScheduleChange
        , updates UpdatesChange
        ]


view : Model -> Html msg
view model =
    div []
        [ div [] <| List.map scheduleView model.schedule
        , div [] <| List.map updateView model.updates
        ]


scheduleView : ScheduleItem -> Html msg
scheduleView item =
    div []
        [ div [] [ text item.event ]
        , div [] [ text item.location ]
        , div [] [ text item.tag ]
        , div [] [ text <| toString item.time ]
        ]


updateView : UpdateItem -> Html msg
updateView item =
    div []
        [ div [] [ text item.title ]
        , div [] [ text item.description ]
        , div [] [ text item.tag ]
        , div [] [ text <| toString item.time ]
        ]
