module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer

haks :: [Aksara] -> Text -> Haksara a
haks xs candidate = do
  (HaksaraConfig tokenizer aksaranator glyphinate) <- ask
  let m_token = charCheck tokenizer candidate
  let 
  return []

charCheck :: (Text -> Maybe b) -> Text -> Maybe b
charCheck tokenizer candidate = tokenizer candidate


