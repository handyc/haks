module Haks.Engine where

import BasicPrelude hiding (filter)
import Data.Text
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer
import Haks.Chinese.Types

charCheck :: (Text -> Maybe b) -> Text -> Maybe b
charCheck tokenizer candidate = tokenizer candidate


