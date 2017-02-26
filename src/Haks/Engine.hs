module Haks.Engine where

import BasicPrelude hiding (empty,filter)
import Control.Monad
import Data.Text hiding (map,foldl',concatMap)
import Data.Char

import Haks.Types
import Haks.NGram
import Haks.Utilities

haks :: [Char] -> ParticleConfig -> Int -> [NGram]
haks corpus (ParticleConfig pre_processor tokenate cleanup particulizor) n =
  (ngram n . (particulizor empty []) . cleanup . tokens . pre_processor) corpus
  where
    tokens = mapMaybe tokenate  
