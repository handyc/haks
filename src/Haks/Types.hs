module Haks.Types where

import BasicPrelude hiding (empty)
import Control.Monad.Reader
import Data.Sequence
import Data.Maybe
import Data.Text hiding (empty)

data ParticleConfig = ParticleConfig
  { pre_processor_hc :: [Char] -> [Char]
  , tokenizer_hc     :: Char -> Maybe (Token,Char)
  , cleanup_hc       :: [(Token,Char)] -> [(Token,Char)]
  , particlate_hc    :: Text -> [Particle] -> [(Token,Char)] -> [Particle]
  }

type Particle = Text

data Token 
  = Chinese
  | TIBETAN_ROMAN
  | Space
  | TIBETAN_UCHEN UChenToken
  | SANSKRIT_ROMAN SKTR
  | SANSKRIT_DEVA
    deriving (Eq,Show)

data SKTR
  = SKTR_CONSONANT
  | SKTR_VOWEL
  | SKTR_TERMINAL
  | SKTR_DIGIT
    deriving (Eq,Show)

data UChenToken
  = TSheg
  | StdChar_UC
    deriving (Eq,Show)

type NGram = Text

init_syllable :: Seq Particle
init_syllable = empty
