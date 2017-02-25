module Haks.Tibetan.Roman.Tokenizer where

import BasicPrelude hiding (filter)

import Data.Text
import Data.Char

import Haks.Types
import Haks.Utilities

tokenizer :: Text -> Maybe (Token, Text)
tokenizer tok = (,) TIBETAN_ROMAN <$> fromBool isTok tok
  where
    isTok = tok == alphaNum
    alphaNum = filter (not . isAlphaNum) tok
