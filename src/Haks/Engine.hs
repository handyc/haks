module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.Chinese.Tokenizer

haks :: [Text] -> ParticleConfig -> Seq Particle
haks corpus (ParticleConfig tokenate glyphIT particlizor) = 
  (particles . glyphs . tokens) corpus
  where
    tokens    = mapMaybe tokenate
    glyphs    = foldl' glyphIT init_glyph
    particles = foldl' particlizor init_syllable
