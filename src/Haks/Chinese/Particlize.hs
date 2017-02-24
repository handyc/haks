module Haks.Chinese.Particlize where

import BasicPrelude hiding (null)
import Data.Sequence

import Haks.Types
import Haks.Chinese.Tokenizer

glyphinate :: Seq Glyph -> (Token,Text) -> Seq Glyph
glyphinate glyphs (_,char)
  | (null glyphs) = singleton glyph
  | otherwise     = glyphs |> glyph
  where
    glyph = Glyph { glyph_g = char, complete_g = True }

particlize :: Seq Particle -> (Token,Text) -> Seq Particle
particlize particles (_,char) 
  | (null particles) = singleton particle
  | otherwise        =  particles |> particle
  where
    particle = Particle { particle_a = char, complete_a = True }

chinese_config :: ParticleConfig
chinese_config = ParticleConfig 
  { tokenizer_hc  = tokenizer
  , particlize_hc   = particlize
  }

test :: [Text]
test = "夫":"宗":"極":"絕":"於":"稱":"謂":"賢":"聖":"以":"之":"沖":"默":"玄":"旨":"非":"言":"不":"傳" : []
