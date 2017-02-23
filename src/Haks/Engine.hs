module Haks.Engine where

import BasicPrelude hiding (filter)
import Data.Text
import Data.Char

import Haks.Chinese.Tokenizer
import Haks.Chinese.Types

charCheck :: (Text -> Maybe b) -> Text -> b
charCheck = error ("charCheck undefined")

