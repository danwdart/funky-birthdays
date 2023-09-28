module Conversion (daysToSeconds, yearsToSeconds) where

import Constants      (secondsInAverageCalendarYear)
import Number.SI.Unit (secondsPerDay)

daysToSeconds, yearsToSeconds ∷ Double → Integer
daysToSeconds d = round (d * secondsPerDay)
yearsToSeconds d = round (d * fromInteger secondsInAverageCalendarYear)
