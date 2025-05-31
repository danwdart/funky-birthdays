{-
Bootstrap
Title
Menu with credits
Description
Name / Dob
Add +
Inside a pane
Options hidden by default +
Maximum years
Numbers
Binary checkbox
Powers of 10
Otherwise options in a matrix
Start from date time default now
Generate calendar button
Copyright notice
-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo               #-}

import Data.Foldable
-- import Data.Map (Map)
import Data.Text (Text)
import Reflex.Dom

htmlHead ∷ MonadWidget t m ⇒ m ()
htmlHead = do
  elAttr
    "link"
    [ ("href", "https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"),
      ("rel", "stylesheet"),
      ("integrity", "sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"),
      ("crossorigin", "anonymous")
    ]
    blank
  elAttr
    "link"
    [ ("href", "/css/index.css"),
      ("rel", "stylesheet")
    ]
    blank
  elAttr
    "link"
    [ ("href", "/img/favicon.png"),
      ("rel", "shortcut icon")
    ]
    blank
  elAttr
    "meta"
    [ ("charset", "utf-8")
    ]
    blank
  traverse_ (\(name', content') -> elAttr "meta" [("name", name'), ("content", content')] blank) ([
    ("description", "Funky Birthdays lets you generate a calendar from interesting anniversaries."),
    ("Content-Type", "text/html; charset=utf-8"),
    ("X-UA-Compatible", "IE=edge,chrome=1"),
    ("viewport", "width=device-width, initial-scale=1"),
    ("favicon", "/img/favicon.png")
    ] :: [(Text, Text)])
  el "title" $ text "Funky Birthdays"


main ∷ IO ()
main = mainWidgetWithHead htmlHead $
    mdo
        el "header" $ text ""
        el "main" $ do
            elAttr "div" [("class", "container")] $ do
                elAttr "div" [("class", "px-4 py-5 my-3 text-center")] $ do
                    el "h1" $ text "Funky Birthdays"
                    elAttr "p" [("class", "lead")] $ text "Generate a calendar using interesting anniversaries"
                    el "p" $ text "Step 1"

                    el "p" $ text "Step 2"

                    el "p" $ text "Step 3"
        -- elAttr "footer" [("class", "footer")] $
        --     elAttr "div" [("class", "container")] $
        --         elAttr "span" [("class", "muted")] $
        --             text "Copyright © Dan Dart, 2025"

