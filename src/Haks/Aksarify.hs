module Haks.Aksarify where

import Data.Monoid
import Data.Text

import Haks.Types

glyphinate :: Text -> Glyph -> Glyph
glyphinate tok glyph@(Glyph building _ _) = glyph {glyph_g = new}
  where new = building <> tok
    
    
aksarify :: Glyph -> Aksara -> Aksara
aksarify (Glyph glyph _ _) aksara@(Aksara building _ _) = 
  aksara {aksara_a = new}
  where new = building <> glyph 
