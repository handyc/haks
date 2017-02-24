{-# LANGUAGE ViewPatterns #-}
module Haks.NGram where

import BasicPrelude hiding (drop,take,empty,null)
import Data.Foldable hiding (null,concat)
import Data.Sequence

import Haks.Types

ngram :: Int -> Seq Particle -> Seq NGram
ngram _ (null -> True) = empty
ngram n particles = item <| (ngram n rest) 
  where
    item = concat $ toList (particle_a <$> (take n particles))
    rest = drop 1 particles
