module Ranges (upToMax) where

import           Types (DayOfInterest)

maxForOne ∷ DayOfInterest
maxForOne = 1000

upToMax ∷ [DayOfInterest]
upToMax = [1..maxForOne]
