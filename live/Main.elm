port module Main exposing (..)

import Html exposing (..)
import Json.Decode exposing (..)
import Json.Encode
import Time exposing (..)
import Date
import Html.Attributes exposing (id, class, href)


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
    , scheduleLoaded : Bool
    , updates : List UpdateItem
    , updatesLoaded : Bool
    }


type alias ScheduleItem =
    { event : String
    , location : String
    , tag : String
    , time : Time
    }


type alias UpdateItem =
    { title : String
    , description : String
    , tag : String
    , time : Time
    }


init : ( Model, Cmd msg )
init =
    ( Model [] False [] False, Cmd.none )


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
                    (field "time" float)

        updatesDecoder =
            list <|
                map4 UpdateItem
                    (field "title" string)
                    (field "description" string)
                    (field "tag" string)
                    (field "time" float)
    in
        case msg of
            ScheduleChange value ->
                case decodeValue scheduleDecoder value of
                    Ok schedule ->
                        ( { model | schedule = schedule, scheduleLoaded = True }, Cmd.none )

                    Err _ ->
                        ( model, Cmd.none )

            UpdatesChange value ->
                case decodeValue updatesDecoder value of
                    Ok updates ->
                        ( { model | updates = updates, updatesLoaded = True }, Cmd.none )

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
    div [ id "live-wrapper" ]
        [ h1 [ id "live-header" ]
            [ text "Los Altos Hacks"
            , span [] [ text "Live" ]
            ]
        , div [ id "live-content" ]
            [ div [ id "toolbar-container" ]
                [ a [ class "toolbar-button blue", href "https://drive.google.com/open?id=14Lqb-RDxgzJcSCmgyQ8zz8eVl5bsAI96UEAQguIifSI" ]
                    [ i [ class "fa fa-gears fa-2x" ] []
                    , h3 [] [ text "Hardware" ]
                    ]
                , a [ class "toolbar-button orange", href "/#faq" ]
                    [ i [ class "fa fa-question fa-2x" ] []
                    , h3 [] [ text "FAQ" ]
                    ]
                , a [ class "toolbar-button red", href "https://losaltoshacks2.devpost.com/" ]
                    [ i [ class "fa fa-code fa-2x" ] []
                    , h3 [] [ text "Devpost" ]
                    ]
                , a [ class "toolbar-button purple", href "/img/map.jpg" ]
                    [ i [ class "fa fa-map fa-2x" ] []
                    , h3 [] [ text "Map" ]
                    ]
                ]
            , div [ class "column" ]
                [ h3 [ class "column-title" ]
                    [ if model.scheduleLoaded then
                        if List.isEmpty model.schedule then
                            text "No events yet"
                        else
                            text "Schedule"
                      else
                        text "Schedule loading..."
                    ]
                , div [ id "schedule-container", class "flex-item" ] <| List.map scheduleView model.schedule
                ]
            , div [ class "column" ]
                [ div [ id "updates-container", class "flex-item" ] <| List.map updateView model.updates
                , h3 [ class "column-title" ]
                    [ if model.updatesLoaded then
                        if List.isEmpty model.updates then
                            text "No updates yet"
                        else
                            text "Updates"
                      else
                        text "Updates loading..."
                    ]
                ]
            ]
        ]


toReadableTime : Time -> String
toReadableTime epoch =
    let
        date =
            Date.fromTime (epoch * 1000)

        h =
            (Date.hour date + 8) % 24

        -- Timezone correction
        period =
            if h < 12 then
                "am"
            else
                "pm"

        adjustedHour =
            if h == 0 || h == 12 then
                12
            else
                (h % 12)

        m =
            Date.minute date

        adjustedMinute =
            if m == 0 then
                toString m ++ "0"
            else
                toString m

        readableDate =
            toString adjustedHour ++ ":" ++ adjustedMinute ++ period
    in
        readableDate


scheduleView : ScheduleItem -> Html msg
scheduleView item =
    div [ class "schedule-view" ]
        [ h2 [] [ text item.event ]
        , p [] [ text item.location ]
        , p [] [ text <| toReadableTime item.time ]
        , div [ class "tag" ] [ h5 [ class item.tag ] [ text item.tag ] ]
        ]


updateView : UpdateItem -> Html msg
updateView item =
    div [ class "update-view" ]
        [ h2 [] [ text item.title ]
        , p [] [ text item.description ]
        , p [] [ text <| toReadableTime item.time ]
        , div [ class "tag" ] [ h5 [ class item.tag ] [ text item.tag ] ]
        ]
