module Conveyor.Health where

import Prelude

import Conveyor.Servable (class Servable, serve)
import Conveyor.Types (Responder(..))
import Foreign (unsafeToForeign)
import Node.HTTP (requestMethod)

newtype Health server = Health server

instance servableHealth :: Servable ex server => Servable ex (Health server) where
  serve (Health server) extraData rawData =
    case requestMethod rawData.req, rawData.path of
      "GET", "health" -> pure $ Responder
        { contentType: "text/plain; charset=utf-8"
        , code: 200
        , body: unsafeToForeign ""
        }
      _, _ -> serve server extraData rawData
