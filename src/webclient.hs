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

{-# LANGUAGE CPP               #-}
{-# LANGUAGE OverloadedLists   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo       #-}
{-# OPTIONS_GHC -Wwarn #-}

import Control.Monad (void)
import Data.Foldable
-- import Data.Map (Map)
import Data.Text     (Text)
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
        el "header" blank
        el "main" $ do
            elAttr "div" [("class", "container")] $ do
                elAttr "div" [("class", "px-4 py-5 my-3 text-center")] $ do
                    el "h1" $ text "Funky Birthdays"
                    elAttr "p" [("class", "lead")] $ text "Generate a calendar using interesting anniversaries"
                    el "h2" $ text "Step 1"
                    void $ do
                      el "p" $ text "Enter the dates to calculate from (e.g. dates of birth, anniversaries, important dates) in Gregorian:"
                      -- reflex input
                      -- elAttr "input" [("type", "datetime")]
                      divClass "form-group" $ do
                        elAttr "label" [("for", "datetime_0")] $ text "Date/Time"
                        inputElement $ def
                          & inputElementConfig_elementConfig . elementConfig_initialAttributes .~ [
                            ("id", "datetime_0"),
                            ("type", "datetime"),
                            ("class", "form-control"),
                            ("placeholder", "2025-06-02T12:06:00+01:00")
                            ]
                    el "h2" $ text "Step 2"

{-
Options:
[ ] Standard Units (default: round)
    [ ] Seconds
    [ ] Minutes
    [ ] Hours
    [ ] Days (24 hours)
    [ ] Weeks

[ ] Earth Years (default: 1-1000)
    [ ] Common Calendar (365 days)
    [ ] Average Calendar (365.2425 days)
    [ ] Leap Calendar (366 days)
    [ ] Julian Astronomical (365.25 days)
    [ ] Sidereal (365.25636574 days)

[ ] Month Types (default: round)
    [ ] Average Draconitic Months (27.212220815 days)
    [ ] Average Tropical Months (27.321582252 days)
    [ ] Average Sidereal Months (27.321661554 days)
    [ ] Average Anomalistic Months (27.554549886 days)
    [ ] Average Synodic Months (29.530588861 days)

[ ] Other Planets (default: round)
    [ ] Cyllenian (Mercurian)
      [ ] Days
      [ ] Years
    [ ] Cytherean / Luciferian (Venusian)
      [ ] Days
      [ ] Years
    [ ] Martian / Arean
      [ ] Days
      [ ] Years
    [ ] Jovian, or Zeusian
      [ ] Days
      [ ] Years
    [ ] Cronian (Saturnian or Saturnial)
      [ ] Days
      [ ] Years
    [ ] Caelian (Uranian)
      [ ] Days
      [ ] Years
    [ ] Poseidean (Neptunian)
      [ ] Days
      [ ] Years

Count types:
[ ] 1-1000
[ ] "Round"
  [ ] Decimal (1..9 × 10^0..10)
  [ ] Binary (2^1..30)
-}

                    el "h2" $ text "Step 3"
                    do
                      el "button" $ text "Generate!"
                    el "p" $ text "Results"
                      -- First n results would go here
                      -- Download as iCal
        -- elAttr "footer" [("class", "footer")] $
        --     elAttr "div" [("class", "container")] $
        --         elAttr "span" [("class", "muted")] $
        --             text "Copyright © Dan Dart, 2025"


