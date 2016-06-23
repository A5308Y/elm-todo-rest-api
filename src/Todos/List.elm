module Todos.List exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Todos.Messages exposing (Msg (Revert, Complete, Patch, Delete))
import Todos.Models exposing (Todo)


-- the main view here is a table with headers and body rows for each todo
view : List Todo -> Html Msg
view todos =
    table []
        [ thead []
            [ th [] [ text "Id" ]
            , th [] [ text "Title" ]
            , th [] [ text "Completed?" ]
            , th [] [ text "Actions" ]
            ]
        -- below, we keep things modular by mapping a todo row view to every todo
        , tbody [] <| List.map todo <| todos
        -- note:
        -- instead, the above could have been:
        --     tbody [] (List.map todo todos)
        -- but, it does demonstrate a good use of the
        -- right-to-left function application operator
        ]

-- a single todo row
todo : Todo -> Html Msg
todo t =
    let
        { id, title, completed } = t

        (completedText, buttonText, buttonMsg) =
            if completed then
                ("Yes", "Revert", Revert)
            else
                ("No", "Done", Complete)
    in
        tr []
            [ td [] [ text <| toString <| id ]
            , td [] [ text title ]
            , td [] [ text completedText ]
            , td []
                [ button
                    [ onClick <| buttonMsg <| t ]
                    [ text buttonText ]
                , button
                    [ onClick <| Patch <| t ] -- TODO
                    [ text "Edit" ]
                , button
                    [ onClick <| Delete <| t ]
                    [ text "Delete" ]
                ]
            ]
