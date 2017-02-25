module Haks.Engine where

import BasicPrelude hiding (empty,filter)
import Control.Monad.Reader
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.NGram
import Haks.Utilities

haks :: [Text] -> ParticleConfig -> Int -> [NGram]
haks corpus (ParticleConfig tokenate particulizor) n = 
  (ngram n . (particulizor empty []) . oneSpace . tokens) corpus
  where
    tokens    = mapMaybe tokenate


