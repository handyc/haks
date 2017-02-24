module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer

haks :: [Text] -> Hakshara a
haks corpus = do
  (SyllableConfig tokenizer syllablinator glyphIT) <- ask
  let tokens    = mapMaybe (charCheck tokenizer) corpus
      glyphs    = foldl' glyphIT init_glyph tokens
      syllables = foldl' syllablinator init_syllable glyphs
  return syllables

charCheck :: (Text -> Maybe b) -> Text -> Maybe b
charCheck tokenizer candidate = tokenizer candidate


