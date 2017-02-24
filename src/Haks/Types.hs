module Haks.Types where

import BasicPrelude hiding (empty)
import Control.Monad.Reader
import Data.Sequence
import Data.Maybe
import Data.Text hiding (empty)

data ParticleConfig = ParticleConfig
  { tokenizer_hc     :: (Text -> Maybe (Token,Text))
  , particlize_hc :: (Seq Particle -> (Token,Text) -> Seq Particle)
  }

data Glyph = Glyph
  { glyph_g      :: Text
  , complete_g   :: Bool
  } deriving Show
  

data Particle = Particle
  { particle_a   :: Text
  , complete_a   :: Bool 
  } deriving Show

data Token 
  = Chinese
  | TIBETAN_ROMAN
  | TIBETAN_UCHEN
  | SANSKRIT_UNICODE
  | SANSKRIT_DEVA
    deriving Show

data Strength = Strength
data Tone     = Tone

type NGram = Text
init_glyph :: Seq Glyph
init_glyph = empty

init_syllable :: Seq Particle
init_syllable = empty
