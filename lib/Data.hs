{-# LANGUAGE UnicodeSyntax #-}
module Data (times, people) where

import           Data.DateTime
import           Constants
import           Conversion
import           Ranges     (upToMax)
import           Round      (roundNumbers)
import           Types      (PersonData, Row)
import           Number.SI.Unit

times ∷ [Row]
times = [
    ("Seconds", 1, roundNumbers),
    ("Minutes", floor (secondsPerMinute :: Double), roundNumbers),
    ("Hours", floor (secondsPerHour :: Double), roundNumbers),
    ("Days", floor (secondsPerDay :: Double), roundNumbers),
    ("Weeks", 7 * floor (secondsPerDay :: Double), roundNumbers),
    ("Sidereal Years",  secondsInSiderealYear, upToMax),
    ("Average Calendar Years", secondsInAverageCalendarYear, upToMax),
    ("Common Calendar Years", secondsInCommonCalendarYear, upToMax),
    ("Julian Astronomical Years", secondsInJulianAstronomicalYear, upToMax),
    ("Leap Calendar Years", secondsInLeapCalendarYear, upToMax),
    ("Average Draconitic Months", daysToSeconds 27.212220815, roundNumbers),
    ("Average Tropical Months", daysToSeconds 27.321582252, roundNumbers),
    ("Average Sidereal Months", daysToSeconds 27.321661554, roundNumbers),
    ("Average Anomalistic Months", daysToSeconds 27.554549886, roundNumbers),
    ("Average Synodic Months", daysToSeconds 29.530588861, roundNumbers),
    ("Cyllenian (Mercurian) Days", daysToSeconds 58.6, roundNumbers),
    ("Cyllenian (Mercurian) Years", daysToSeconds 87.97, roundNumbers),
    ("Cytherean / Luciferian (Venusian) Days", daysToSeconds 243, roundNumbers),
    ("Cytherean / Luciferian (Venusian) Years", daysToSeconds 224.7, roundNumbers),
    ("Martian / Arean Days", daysToSeconds 1.03, roundNumbers),
    ("Martian / Arean Years", yearsToSeconds 1.88, roundNumbers),
    ("Jovian, or Zeusian Days", daysToSeconds 0.41, roundNumbers),
    ("Jovian, or Zeusian Years", yearsToSeconds 11.86, roundNumbers),
    ("Cronian (Saturnian or Saturnial) Days", daysToSeconds 0.45, roundNumbers),
    ("Cronian (Saturnian or Saturnial) Years", yearsToSeconds 29.46, roundNumbers),
    ("Caelian (Uranian) Days", daysToSeconds 0.72, roundNumbers),
    ("Caelian (Uranian) Years", yearsToSeconds 84.01, roundNumbers),
    ("Poseidean (Neptunian) Days", daysToSeconds 0.67, roundNumbers),
    ("Poseidean (Neptunian) Years", yearsToSeconds 164.79, roundNumbers)
    ]

people ∷ [PersonData]
people = [
    ("Dan", fromGregorian 1991 6 4 0 37 0),
    ("Colin", fromGregorian 1991 6 10 0 0 0),
    ("Kaychan", fromGregorian 1992 11 19 0 0 0)
    ]
