module Haks.Types where

import Control.Monad.Reader
import Data.Maybe
import Data.Text

type Hakshara b = Reader (SyllableConfig b) [Syllable]

data SyllableConfig b = SyllableConfig
  { tokenizer_hc     :: (Text -> Maybe b)
  , syllablinator_hc :: (Glyph -> Syllable -> Syllable)
  , glyphinate_hc    :: (Text  -> Glyph  -> Glyph)
  }
data Glyph = Glyph
  { glyph_g      :: Text
  , strength_g   :: Strength
  , tone_g       :: Tone
  }

data Syllable = Syllable
  { syllable_a   :: Text
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
