module Haks.Types where

import Control.Monad.Reader
import Data.Maybe
import Data.Text

type Haksara b = Reader (HaksaraConfig b) [Aksara]

data HaksaraConfig b = HaksaraConfig
  { tokenizer_hc   :: (Text -> Maybe b)
  , aksaranator_hc :: (Glyph -> Aksara -> Aksara)
  , glyphinate_hc  :: (Text  -> Glyph  -> Glyph)
  }
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

data Token 
  = Chinese
  | TIBETAN_ROMAN
  | TIBETAN_UCHEN
  | SANSKRIT_UNICODE
  | SANSKRIT_DEVA
data Strength = Strength
data Tone     = Tone
