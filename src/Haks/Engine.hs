module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer

haks :: [Text] -> SyllableConfig a -> Seq Syllable
haks corpus (SyllableConfig tokenizer glyphIT syllablinator) = 
  (syllables . glyphs . tokens) corpus
  where
    tokens    = mapMaybe tokenizer
    glyphs    = foldl' glyphIT init_glyph
    syllables = foldl' syllablinator init_syllable

