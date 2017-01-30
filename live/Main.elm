port module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (..)
import Json.Encode
import Html.Attributes exposing (id, class)


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
    div [ id "live-content" ]
        [ div [ id "schedule-container", class "flex-item"] <| List.map scheduleView model.schedule
        , div [ id "updates-container", class "flex-item" ] <| List.map updateView model.updates
        ]


scheduleView : ScheduleItem -> Html msg
scheduleView item =
    div [ class "schedule-view" ]
        [ h2 [] [ text item.event ]
        , p  [] [ text item.location ]
        , p  [] [ text item.tag ]
        , p  [] [ text <| toString item.time ]
        ]


updateView : UpdateItem -> Html msg
updateView item =
    div [ class "update-view" ]
        [ h2  [] [ text item.title ]
        , p   [] [ text item.description ]
        , p   [] [ text item.tag ]
        , p   [] [ text <| toString item.time ]
        ]
