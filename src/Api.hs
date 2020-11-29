{-# LANGUAGE UnicodeSyntax #-}
import           AWSLambda.Events.APIGateway
import           Control.Lens
import           Data.Aeson.Embedded
import           Data.Time

main ∷ IO ()
main = apiGatewayMain handler

handler ∷ APIGatewayProxyRequest (Embedded UTCTime) → IO (APIGatewayProxyResponse String)
handler request = do
  print $ request ^. requestBody
  pure $ responseOK & responseBody ?~ "OK"
