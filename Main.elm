module Main exposing (..)

import Html exposing (Html)
import Material
import Material.Button as Button
import Material.Dialog as Dialog
import Material.Options
import Material.Textfield as Textfield

dialog : Material.Model -> Model -> Html Msg
dialog mdl model =
    Dialog.view
        []
        [ Dialog.title [] []
        , Dialog.content [] [ viewForm mdl model ]
        , Dialog.actions [] []
        ]


viewForm : Material.Model -> Model -> Html Msg
viewForm mdl model =
    Textfield.render Mdl
        [ 0 ]
        mdl
        [ Textfield.label "Input"
        , Textfield.floatingLabel
        , Textfield.text_
        , Material.Options.onInput (OnChange Name)
        , Textfield.value model.name
        ]
        []


type Name
    = Name

type Msg
    = Mdl (Material.Msg Msg)
    | OnChange Name String


type alias Model =
    { name : String
    , mdl : Material.Model
    }


main =
    Html.program
    { view = view
    , init = defaultModel ! []
    , update = update
    , subscriptions = always Sub.none
    }


defaultModel =
    { name = ""
    , mdl = Material.model
    }


update msg model =
    case msg of
        OnChange _ _ -> model ! []
        Mdl msg ->
            Material.update Mdl msg model


view model =
    Html.div
    []
    [ Button.render Mdl [0] model.mdl
      [ Dialog.openOn "click" ]
      [ Html.text "Open dialog" ]
    , dialog model.mdl model
    ]
