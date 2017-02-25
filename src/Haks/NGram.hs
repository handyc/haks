{-# LANGUAGE ViewPatterns #-}
module Haks.NGram where

import BasicPrelude
import Data.Foldable hiding (concat)

import Haks.Types

ngram :: Int -> [Particle] -> [NGram]
ngram _ [] = []
ngram n particles = item : (ngram n rest) 
  where
    item = concat $ toList (take n particles)
    rest = drop 1 particles
