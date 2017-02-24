module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer

haks :: [Syllable] -> Text -> Hakshara a
haks xs candidate = do
  (SyllableConfig tokenizer syllablinator glyphinate) <- ask
  let m_token = charCheck tokenizer candidate
  return []

charCheck :: (Text -> Maybe b) -> Text -> Maybe b
charCheck tokenizer candidate = tokenizer candidate


