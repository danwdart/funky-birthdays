{-# LANGUAGE UnicodeSyntax #-}
module Utils (untilEnd) where

import           Data           (people, times)
import           Data.DateTime
import           Data.List      (sortOn)
import           Data.Time
import           Number.SI.Unit
import           Types          (DateNameTime)

filterDays ∷ UTCTime → UTCTime → [DateNameTime] → [DateNameTime]
filterDays fromDay untilDay = takeWhile ((<= untilDay) . snd) . dropWhile ((<= fromDay) . snd)

birthTimes ∷ [DateNameTime]
birthTimes = do
    (name, bdtime) <- people

    (timename, secs, numbers) <- times
    number <- numbers

    return (name <> (": " <> (show number <> (" " <> timename))), addSeconds (number * secs) bdtime)

untilEnd ∷ UTCTime → [DateNameTime]
untilEnd now = do
    filterDays now (addSeconds (5 * floor (secondsPerYear :: Double)) now) (sortOn snd birthTimes)
