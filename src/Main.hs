module Main (main) where

import Data.ByteString.Lazy.Char8 qualified as BSL
import Data.Map
import Data.Time.Clock
import ICalendar
import Utils                      (untilEnd)

main ∷ IO ()
main = do
    now <- getCurrentTime
    let ical = generateICal . fromList . untilEnd $ now
    BSL.writeFile "events.ics" ical
    putStrLn "Wrote events.ics"
