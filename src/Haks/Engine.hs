module Haks.Engine where

import BasicPrelude hiding (filter)
import Control.Monad.Reader
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.NGram
import Haks.Chinese.Tokenizer

haks :: [Text] -> ParticleConfig -> Int -> Seq NGram
haks corpus (ParticleConfig tokenate particlizor) n = 
  (ngram n . particles . tokens) corpus
  where
    tokens    = mapMaybe tokenate
    particles = foldl' particlizor init_syllable
