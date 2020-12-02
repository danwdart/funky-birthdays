{-# LANGUAGE UnicodeSyntax #-}
import           AWSLambda.Events.APIGateway
import           Control.Lens
-- import           Data.Aeson.Embedded
import           Data.Text
-- import           Data.Time

main ∷ IO ()
main = apiGatewayMain handler

handler ∷ APIGatewayProxyRequest Text → IO (APIGatewayProxyResponse String)
handler request = do
  print $ request ^. agprqQueryStringParameters
  pure $ responseOK & responseBody ?~ "OK"
