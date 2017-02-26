{-# LANGUAGE ViewPatterns #-}
module Haks.Tibetan.Roman.Particulator where

import BasicPrelude hiding (filter,all,null,empty)

import Data.Text hiding (reverse)
import Data.Char hiding (Space)

import Haks.Types
import Haks.Utilities

tokenizer :: Char -> Maybe (Token, Char)
tokenizer tok 
  | isAlpha' = Just (TIBETAN_ROMAN, tok)
  | tok == '\'' = Just (TIBETAN_ROMAN, tok)
  | isSpace'    = Just (Space,tok)
  | otherwise   = Nothing
  where
    isTok    = isAlpha' || isSpace'
    isAlpha' = isAlpha tok
    isSpace' = isSpace tok

oneSpace :: [(Token,Char)] -> [(Token,Char)]
oneSpace []                       = []
oneSpace ((Space,_):space@(Space,_):xs) = space:oneSpace xs
oneSpace (x:xs)                   = x:oneSpace xs

particulate :: Text -> [Particle] -> [(Token,Char)] -> [Particle]
particulate (null -> True) particles [] = reverse particles
particulate particle particles ((Space,_):xs) = 
  (particle:particles) ++ (particulate empty [] xs)
particulate particle particles ((_,char):xs) = 
  particulate (particle `append` (pack $ char : [])) particles xs
particulate _ _ [] = []

tibetan_r :: ParticleConfig
tibetan_r = ParticleConfig
  { pre_processor_hc = id
  , tokenizer_hc = tokenizer
  , cleanup_hc   = oneSpace
  , particlate_hc = particulate
  }


test :: [Char]
test = ['@','1','B',' ','*',',',' ',',','\'','D','U','L',' ','\'','D','Z','I','N',' ','C','H','E','N',' ','P','O',' ','G','N','A','S',' ','B','R','T','A','N',' ','N','Y','E',' ','B','A','R',' ','\'','K','H','O','R',',',' ',',']
