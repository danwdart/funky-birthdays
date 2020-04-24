module Funk.Types (PersonName, DayOfInterest, NameOfTimeframe, DateName, SecondsPerTimeframe, Row, PersonData, DateNameTime) where

import Data.Time (UTCTime)

type PersonName = String
type DayOfInterest = Integer
type NameOfTimeframe = String
type DateName = String
type SecondsPerTimeframe = Integer
type Row = (NameOfTimeframe, SecondsPerTimeframe, [DayOfInterest])
type PersonData = (PersonName, UTCTime)
type DateNameTime = (DateName, UTCTime)