module Haks.Types where

import Data.Text

data Glyph = Glyph
  { glyph_g      :: Text
  , strength_g   :: Strength
  , tone_g       :: Tone
  }

data Aksara = Aksara
  { aksara_a   :: Text
  , strength_a :: Strength
  , tone_a     :: Tone
  }

data Strength = Strength
data Tone     = Tone
